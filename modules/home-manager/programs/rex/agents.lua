-- agent_send: Neovim pastes text or a file reference into a coding agent's prompt.

local TERMINAL = "com.superlogical.terminal"
local HOME = os.getenv("HOME")
local AGENT_APPS = { ["claude-code"] = true, codex = true, omp = true, opencode = true, pi = true }

local function terminal(block_id, method)
	return rex.block.call(TERMINAL, method, { block_id = block_id }) or {}
end

local function same_process(a, b)
	return a and b and a.pid == b.pid and a.name == b.name
end

local function foreground_agent(block_id)
	local records = terminal(block_id, "program_status").records or {}
	if #records == 0 then return end
	local foreground = terminal(block_id, "process").foreground
	for _, record in ipairs(records) do
		if AGENT_APPS[record.effective_app or record.app] and same_process(record.owner, foreground) then
			return record, foreground
		end
	end
end

local function agents_among(blocks)
	local agents = {}
	for _, block in ipairs(blocks) do
		local record, process = foreground_agent(block.block_id)
		if record then
			agents[#agents + 1] = { block_id = block.block_id, label = block.label, record = record, process = process }
		end
	end
	return agents
end

local function agents_near(block_id)
	local blocks = assert(rex.session.list_blocks {}).blocks or {}
	local tab
	for _, block in ipairs(blocks) do
		if block.block_id == block_id then tab = block.window_id end
	end
	local same_tab, other_tabs = {}, {}
	for _, block in ipairs(blocks) do
		if block.creator_name == TERMINAL and block.window_id and block.block_id ~= block_id then
			table.insert(block.window_id == tab and same_tab or other_tabs, block)
		end
	end
	local agents = agents_among(same_tab)
	return #agents > 0 and agents or agents_among(other_tabs)
end

local function still_running(agent)
	local _, process = foreground_agent(agent.block_id)
	return same_process(process, agent.process) and process
end

local function name(agent)
	return agent.record.title or agent.record.effective_app or agent.record.app or agent.label or "agent"
end

local function tilde(path)
	if HOME and (path == HOME or path:sub(1, #HOME + 1) == HOME .. "/") then
		return "~" .. path:sub(#HOME + 1)
	end
	return path
end

local function pick(agents)
	local items, by_id = {}, {}
	for _, agent in ipairs(agents) do
		by_id[agent.block_id] = agent
		items[#items + 1] = {
			id = agent.block_id,
			title = name(agent),
			subtitle = agent.process.cwd and tilde(agent.process.cwd) or agent.label,
			detail = agent.record.state,
			icon = "terminal"
		}
	end
	local id, why = rex.ui.pick { title = "Send to agent", placeholder = "Filter agents", items = items }
	return by_id[id], why
end

local function choose(agents, preferred)
	if #agents == 1 then return agents[1] end
	for _, agent in ipairs(agents) do
		if agent.block_id == preferred then return agent end
	end
	local agent, why = pick(agents)
	return agent, why, true
end

local function relative(file, dir)
	if not dir or dir == "" then return file end
	local prefix = dir:gsub("/+$", "") .. "/"
	return file:sub(1, #prefix) == prefix and file:sub(#prefix + 1) or file
end

local function line_range(first, last)
	if not first then return "" end
	return "#L" .. first .. (last and last ~= first and "-" .. last or "")
end

local function mention(file, dir, first, last)
	local reference = relative(file, dir) .. line_range(first, last)
	return "@" .. (reference:find("%s") and '"' .. reference .. '"' or reference)
end

local function paste(session_id, block_id, text)
	assert(rex.call("block.event", {
			session_id = session_id,
			block_id = block_id,
			event = { type = "paste", payload = { text = text } }
		}))
end

rex.action {
	name = "agent_send",
	title = "Send to Agent…",
	description = "Pastes text or a file @-mention into an agent's prompt and focuses its pane",
	category = "Agents",
	args = {
		to = "string?",
		text = "string?",
		file = "string?",
		line_start = "integer?",
		line_end = "integer?"
	},
	run = function (ctx, args)
		local text = args.text or ""
		if text == "" and not args.file then return { sent = false, reason = "empty" } end

		local agents = agents_near(ctx.block_id)
		if #agents == 0 then error("there is no agent in this session", 0) end
		local agent, why, picked = choose(agents, args.to)
		if not agent then return { sent = false, reason = why } end

		local process = still_running(agent) or error(name(agent) .. " is no longer running in that pane", 0)
		if args.file then
			text = mention(args.file, process.cwd, args.line_start, args.line_end) .. " " .. text
		end
		paste(ctx.session_id, agent.block_id, text)

		-- The closing picker returns focus to the caller, who then focuses the agent.
		if not picked then assert(rex.session.focus_block { block_id = agent.block_id }) end
		return { sent = true, block_id = agent.block_id, focus_deferred = picked }
	end
}
