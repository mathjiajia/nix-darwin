--- Send text from Neovim to the agent in another Rex pane, through the
--- agent_send action that ~/.config/rex/agents.lua defines.
local M = {}

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.WARN, { title = "Agent" })
end

--- Pastes into the agent's prompt, without submitting it, and moves the focus
--- there so the question can be typed after it.
function M.send(args)
	if not vim.env.REX_SESSION or not vim.env.REX_BLOCK then
		return notify("Not in a Rex terminal")
	end
	args.focus = true
	local cmd = {
		"rex", "do", "agent_send", "-s", vim.env.REX_SESSION, "-b", vim.env.REX_BLOCK,
		"--args", "-", "--json",
	}
	local function on_exit(result)
		if result.code ~= 0 then
			return notify(vim.trim(result.stderr), vim.log.levels.ERROR)
		end
		local ok, reply = pcall(vim.json.decode, result.stdout)
		if not ok or type(reply) ~= "table" or type(reply.sent) ~= "boolean" then
			return notify("Unexpected response from rex do agent_send", vim.log.levels.ERROR)
		end
		if not reply.sent and reply.reason ~= "cancelled" then
			local reason = (reply.reason or "unknown reason"):gsub("_", " ")
			notify("Rex could not send the text (" .. reason .. ")")
		end
	end
	local ok, err = pcall(vim.system, cmd, { stdin = vim.json.encode(args), text = true }, vim.schedule_wrap(on_exit))
	if not ok then notify(tostring(err), vim.log.levels.ERROR) end
end

--- The buffer's file with symlinks resolved, or nil when it has no file on disk.
local function file()
	local name = vim.api.nvim_buf_get_name(0)
	if name == "" or vim.bo.buftype ~= "" then
		return nil
	end
	return vim.uv.fs_realpath(name)
end

local function send_file(path, first, last, text)
	if vim.bo.modified then
		notify("The buffer has unsaved changes; the agent reads the file as saved")
	end
	return M.send({ file = path, line_start = first, line_end = last, text = text })
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

	local path = file()
	if not path then
		local lines = vim.fn.getregion(from, to, { type = visual and mode or "V" })
		return M.send({ text = ("```%s\n%s\n```\n"):format(vim.bo.filetype, table.concat(lines, "\n")) })
	end
	if from[2] > to[2] then from, to = to, from end
	local first, last = from[2], to[2]
	-- An exclusive selection ending at the start of a later line omits that line.
	local at_line_start = to[3] == 1 and to[4] == 0 -- first byte, no virtual offset
	if mode == "v" and vim.o.selection == "exclusive" and first < last and at_line_start then
		last = last - 1
	end
	send_file(path, first, last)
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

	local path = file()
	if not path then
		return M.send({ text = ("[No Name]:%d: %s"):format(row, text) })
	end
	send_file(path, row, nil, text)
end

return M
