-- Paste text or a file reference into the foreground coding agent.

local TERMINAL = "com.superlogical.terminal"
local HOME = os.getenv("HOME")

-- The app names agents report in their status records.
local AGENT_APPS = { ["claude-code"] = true, codex = true, omp = true, opencode = true, pi = true }

local function tilde(path)
	if HOME and (path == HOME or path:sub(1, #HOME + 1) == HOME .. "/") then
		return "~" .. path:sub(#HOME + 1)
	end
	return path
end

--- The status record of the agent in a pane's foreground, and that process, or
--- nil when the foreground program isn't a known agent. A record whose owner
--- has exited, or sits behind a shell or another program, doesn't count.
local function agent_in(block_id)
	local status = rex.block.call(TERMINAL, "program_status", { block_id = block_id })
	local records = status and status.records or {}
	if #records == 0 then return nil end
	local process = rex.block.call(TERMINAL, "process", { block_id = block_id })
	local foreground = process and process.foreground
	if not foreground then return nil end

	for _, record in ipairs(records) do
		local owner = record.owner
		local is_agent = AGENT_APPS[record.effective_app or record.app]
		-- Matching the name as well as the pid rules out a reused pid.
		if is_agent and owner and owner.pid == foreground.pid and owner.name == foreground.name then
			return record, foreground
		end
	end
end

--- The agent panes to choose from: those in the tab of the pane the action
--- ran on, or else those in the whole session when that tab has none. The
--- pane itself counts, listed first, when a person pressed a key or used the
--- palette; a program running `rex do agent_send` never sends to its own pane.
local function agents(ctx)
	local skip_self = ctx.origin == "cli" or ctx.origin == "api"
	local tab
	local blocks = assert(rex.session.list_blocks {}).blocks or {}
	for _, block in ipairs(blocks) do
		if block.block_id == ctx.block_id then
			tab = block.window_id
			break
		end
	end
	local here, elsewhere = {}, {}
	for _, block in ipairs(blocks) do
		local is_self = block.block_id == ctx.block_id
		if block.creator_name == TERMINAL and block.window_id then
			if is_self then
				if not skip_self then table.insert(here, 1, block) end
			elseif block.window_id == tab then
				here[#here + 1] = block
			else
				elsewhere[#elsewhere + 1] = block
			end
		end
	end
	local found = {}
	for _, group in ipairs({ here, elsewhere }) do
		for _, block in ipairs(group) do
			local record, process = agent_in(block.block_id)
			if record then
				found[#found + 1] = { block_id = block.block_id, label = block.label, record = record, process = process }
			end
		end
		if #found > 0 then break end
	end
	return found
end

local function name(agent)
	return agent.record.title or agent.record.effective_app or agent.record.app or agent.label or "agent"
end

--- An @-mention of file and its lines, such as @update.py#L25-27, quoted when
--- the path has spaces, as Claude Code parses it.
local function mention(dir, file, first, last)
	local path = file
	if dir and dir ~= "" then
		local prefix = dir:gsub("/+$", "") .. "/"
		if file:sub(1, #prefix) == prefix then path = file:sub(#prefix + 1) end
	end
	if first then
		last = last or first
		path = path .. "#L" .. first .. (last ~= first and "-" .. last or "")
	end
	if path:find("%s") then path = '"' .. path .. '"' end
	return "@" .. path
end

--- The preferred agent while it's among them, the only agent, or the one the
--- person picks. Returns nil and the reason when they don't pick.
local function choose(found, preferred)
	if #found == 1 then return found[1] end
	local items, by_id = {}, {}
	for _, agent in ipairs(found) do
		items[#items + 1] = {
			id = agent.block_id,
			title = name(agent),
			subtitle = agent.process.cwd and tilde(agent.process.cwd) or agent.label,
			detail = agent.record.state,
			icon = "terminal"
		}
		by_id[agent.block_id] = agent
	end
	if preferred and by_id[preferred] then return by_id[preferred] end
	local id, why = rex.ui.pick { title = "Send to agent", placeholder = "Filter agents", items = items }
	return by_id[id], why
end

rex.action {
	name = "agent_send",
	title = "Send to Agent…",
	description = "Pastes text or a file @-mention into an agent's prompt and focuses its pane by default. Sends to pane `to` without asking while it runs one of the agents to choose from. Asks for text when given neither.",
	category = "Agents",
	args = {
		to = "string?",
		text = "string?",
		file = "string?",
		line_start = "integer?",
		line_end = "integer?",
		submit = "boolean?",
		focus = "boolean?"
	},
	run = function (ctx, args)
		local found = agents(ctx)
		if #found == 0 then error("there is no agent in this session", 0) end
		local agent, why = choose(found, args.to)
		if not agent then return { sent = false, reason = why } end

		local text, submit = args.text, args.submit
		if text == nil and not args.file then
			text, why = rex.ui.input { title = "Send to " .. name(agent), confirm = "Send" }
			if text == nil then return { sent = false, reason = why } end
			if submit == nil then submit = true end
		end

		-- Answering the palette can take a while; check that the agent is still
		-- what the pane runs, so the paste can't land in a shell instead.
		local _, process = agent_in(agent.block_id)
		if not process or process.pid ~= agent.process.pid or process.name ~= agent.process.name then
			error(name(agent) .. " is no longer running in that pane", 0)
		end
		if args.file then
			-- Spaces around it, so it isn't joined to text already in the prompt.
			local ref = mention(process.cwd, args.file, args.line_start, args.line_end)
			text = " " .. ref .. " " .. (text or "")
		end
		if text == "" then return { sent = false, reason = "empty" } end

		assert(rex.call("block.event", {
				session_id = ctx.session_id,
				block_id = agent.block_id,
				event = { type = "paste", payload = { text = text } }
			}))
		if submit then
			assert(rex.block.call(TERMINAL, "write", { block_id = agent.block_id, data = "\r" }))
		end
		if args.focus ~= false then
			assert(rex.session.focus_block { block_id = agent.block_id })
		end
		return { sent = true, block_id = agent.block_id }
	end
}
