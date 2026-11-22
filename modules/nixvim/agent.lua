-- Send lines and diagnostics to a coding agent in another Rex pane, through agent_send in the Rex config.
local block, session = vim.env.REX_BLOCK, vim.env.REX_SESSION
if not block or not session then return end

local M = {}

local PALETTE_CLOSE_MS = 200
local last_send

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

local function well_formed(reply)
	return type(reply) == "table" and type(reply.sent) == "boolean"
		and (not reply.sent or type(reply.block_id) == "string")
end

local function focus_after_palette_closes(reply)
	vim.defer_fn(function ()
		if last_send == reply then
			run_rex({ "rex", "focus", "-s", session, reply.block_id })
		end
	end, PALETTE_CLOSE_MS)
end

function M.send(args)
	local payload = vim.tbl_extend("force", args, { to = last_send and last_send.block_id })
	local cmd = { "rex", "do", "agent_send", "-s", session, "-b", block, "--args", "-", "--json" }
	run_rex(cmd, vim.json.encode(payload), function (stdout)
		local ok, reply = pcall(vim.json.decode, stdout)
		if not ok or not well_formed(reply) then
			return notify("Unexpected response from rex do agent_send", vim.log.levels.ERROR)
		end
		if reply.sent then
			last_send = reply
			if reply.focus_deferred then focus_after_palette_closes(reply) end
		elseif reply.reason ~= "cancelled" then
			local reason = (reply.reason or "unknown reason"):gsub("_", " ")
			notify("Rex could not send the text (" .. reason .. ")")
		end
	end)
end

local function save_without_formatting()
	local autoformat = vim.b.disable_autoformat
	vim.b.disable_autoformat = true
	local ok, err = pcall(vim.cmd, "silent update")
	vim.b.disable_autoformat = autoformat
	return ok, err
end

local function saved_file()
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" or vim.bo.buftype ~= "" then return end
	local ok, err = save_without_formatting()
	if not ok then return nil, tostring(err):match("E%d+:.*") or tostring(err) end
	return vim.uv.fs_realpath(name)
end

local function selection_or_cursor_line()
	local mode = vim.fn.mode()
	local visual = mode == "v" or mode == "V" or mode == "\22"
	local range = { from = vim.fn.getpos("v"), to = vim.fn.getpos("."), type = visual and mode or "V" }
	if visual then vim.cmd.normal({ vim.keycode("<Esc>"), bang = true }) end
	return range
end

local function line_numbers(range)
	local from, to = range.from, range.to
	if from[2] > to[2] then from, to = to, from end
	local first, last = from[2], to[2]
	local stops_before_last_line = range.type == "v" and vim.o.selection == "exclusive"
		and first < last and to[3] == 1 and to[4] == 0
	return first, stops_before_last_line and last - 1 or last
end

local function code_block(range)
	local lines = vim.fn.getregion(range.from, range.to, { type = range.type })
	return ("```%s\n%s\n```\n"):format(vim.bo.filetype, table.concat(lines, "\n"))
end

function M.send_lines()
	local range = selection_or_cursor_line()
	local path, err = saved_file()
	if err then return notify("Could not save the buffer: " .. err, vim.log.levels.ERROR) end
	if not path then return M.send({ text = code_block(range) }) end
	local first, last = line_numbers(range)
	M.send({ file = path, line_start = first, line_end = last })
end

function M.pick_agent_and_send_lines()
	last_send = nil
	M.send_lines()
end

local function describe(diagnostic)
	local severity = vim.diagnostic.severity[diagnostic.severity]:lower()
	local message = diagnostic.message:gsub("%s*\n%s*", " ")
	local source = diagnostic.source and (" [" .. diagnostic.source .. "]") or ""
	return ("%s (col %d): %s%s"):format(severity, diagnostic.col + 1, message, source)
end

function M.send_diagnostics()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local diagnostics = vim.diagnostic.get(0, { lnum = row - 1 })
	if #diagnostics == 0 then return notify("No diagnostics on this line") end
	local text = table.concat(vim.tbl_map(describe, diagnostics), "\n") .. "\n"

	local path, err = saved_file()
	if err then return notify("Could not save the buffer: " .. err, vim.log.levels.ERROR) end
	if not path then return M.send({ text = ("[No Name]:%d: %s"):format(row, text) }) end
	M.send({ file = path, line_start = row, text = text })
end

vim.keymap.set({ "n", "x" }, "<leader>aa", M.send_lines, { desc = "Send line or selection to [a]gent" })
vim.keymap.set({ "n", "x" }, "<leader>as", M.pick_agent_and_send_lines, { desc = "[S]elect [a]gent and send line or selection" })
vim.keymap.set("n", "<leader>ad", M.send_diagnostics, { desc = "Send line [d]iagnostics to [a]gent" })

return M
