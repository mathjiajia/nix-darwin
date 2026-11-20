--- Send text from Neovim to the agent in another Rex pane, through the
--- agent_send action that ~/.config/rex/agents.lua defines.
local M = {}

-- The CLI of the Rex that started this terminal, as floats.lua runs it.
local REX = (vim.env.REX_BIN_DIR or "") ~= "" and vim.env.REX_BIN_DIR .. "/rex" or "rex"

-- The pane the last text went to. Later sends go there without asking, while
-- it still runs an agent.
local target

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.WARN, { title = "Agent" })
end

local function run_rex(cmd, stdin, on_success)
	local function on_exit(result)
		if result.code ~= 0 then
			notify(vim.trim(result.stderr), vim.log.levels.ERROR)
		elseif on_success then
			on_success(result.stdout)
		end
	end
	local ok, err = pcall(vim.system, cmd, { stdin = stdin, text = true }, vim.schedule_wrap(on_exit))
	if not ok then notify(tostring(err), vim.log.levels.ERROR) end
end

-- Closing Rex's agent picker gives the focus back to the pane it opened over,
-- this one, and that can happen after the focus has moved to the agent. So
-- for a moment after the focus leaves for the agent, coming back here sends
-- it to the agent again, once.
local REFOCUS_MS = 2000
local refocus = vim.api.nvim_create_augroup("rex-agent-refocus", { clear = true })
local refocus_timer = assert(vim.uv.new_timer())

local function focus(session, block_id)
	local function go() run_rex({ REX, "focus", "-s", session, block_id }) end
	vim.api.nvim_clear_autocmds({ group = refocus })
	vim.api.nvim_create_autocmd("FocusLost", { group = refocus, once = true, callback = function ()
		vim.api.nvim_create_autocmd("FocusGained", { group = refocus, once = true, callback = go })
	end })
	refocus_timer:start(REFOCUS_MS, 0, vim.schedule_wrap(function ()
		vim.api.nvim_clear_autocmds({ group = refocus })
	end))
	go()
end

--- Pastes into the agent's prompt, without submitting it, and moves the focus
--- there so the question can be typed after it.
function M.send(args)
	local session = vim.env.REX_SESSION
	if not session or not vim.env.REX_BLOCK then
		return notify("Not in a Rex terminal")
	end
	-- Apply focus after the send action and its picker have returned.
	local payload = vim.tbl_extend("force", args, { focus = false, to = target })
	local cmd = { REX, "do", "agent_send", "-s", session, "-b", vim.env.REX_BLOCK, "--args", "-", "--json" }
	run_rex(cmd, vim.json.encode(payload), function (stdout)
		local ok, reply = pcall(vim.json.decode, stdout)
		if not ok or type(reply) ~= "table"
			or type(reply.sent) ~= "boolean" or (reply.sent and type(reply.block_id) ~= "string") then
			return notify("Unexpected response from rex do agent_send", vim.log.levels.ERROR)
		end
		if reply.sent then
			target = reply.block_id
			focus(session, reply.block_id)
		elseif reply.reason ~= "cancelled" then
			local reason = (reply.reason or "unknown reason"):gsub("_", " ")
			notify("Rex could not send the text (" .. reason .. ")")
		end
	end)
end

--- The buffer's file with symlinks resolved, saved first so the agent reads
--- the lines shown here; nil when the buffer has no file on disk, and nil and
--- the error when saving fails. Format-on-save could move the lines, so this
--- save skips it.
local function file()
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" or vim.bo.buftype ~= "" then
		return nil
	end
	local autoformat = vim.b.disable_autoformat
	vim.b.disable_autoformat = true
	local ok, err = pcall(vim.cmd, "silent update")
	vim.b.disable_autoformat = autoformat
	if not ok then
		return nil, tostring(err):match("E%d+:.*") or tostring(err)
	end
	return vim.uv.fs_realpath(name)
end

--- Mentions the selected lines, or the cursor line outside Visual mode, as
--- @file#L25-27 or @file#L3. A buffer with no file on disk has nothing to
--- mention, so the text is pasted in a code block instead.
function M.send_lines()
	local mode = vim.fn.mode()
	local visual = mode == "v" or mode == "V" or mode == "\22"
	-- Outside Visual mode, "v" is the cursor position, so the range is its line.
	local from, to = vim.fn.getpos("v"), vim.fn.getpos(".")
	if visual then
		vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
	end

	local path, err = file()
	if err then
		return notify("Could not save the buffer: " .. err, vim.log.levels.ERROR)
	elseif not path then
		local lines = vim.fn.getregion(from, to, { type = visual and mode or "V" })
		return M.send({ text = ("```%s\n%s\n```\n"):format(vim.bo.filetype, table.concat(lines, "\n")) })
	end
	if from[2] > to[2] then
		from, to = to, from
	end
	local first, last = from[2], to[2]
	-- An exclusive selection ending at the start of a later line omits that line.
	local at_line_start = to[3] == 1 and to[4] == 0 -- first byte, no virtual offset
	if mode == "v" and vim.o.selection == "exclusive" and first < last and at_line_start then
		last = last - 1
	end
	M.send({ file = path, line_start = first, line_end = last })
end

--- Like send_lines, but asks which agent to send to, when there is more than
--- one, and remembers the answer for later sends.
function M.send_lines_to_other()
	target = nil
	M.send_lines()
end

--- Mentions the cursor line, as @file#L3, followed by its diagnostics.
function M.send_diagnostics()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local diagnostics = vim.diagnostic.get(0, { lnum = row - 1 })
	if #diagnostics == 0 then
		return notify("No diagnostics on this line")
	end
	local out = {}
	for _, d in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[d.severity]:lower()
		local message = d.message:gsub("%s*\n%s*", " ")
		local source = d.source and (" [" .. d.source .. "]") or ""
		out[#out + 1] = ("%s (col %d): %s%s"):format(severity, d.col + 1, message, source)
	end
	local text = table.concat(out, "\n") .. "\n"

	local path, err = file()
	if err then
		return notify("Could not save the buffer: " .. err, vim.log.levels.ERROR)
	elseif not path then
		return M.send({ text = ("[No Name]:%d: %s"):format(row, text) })
	end
	M.send({ file = path, line_start = row, text = text })
end

return M
