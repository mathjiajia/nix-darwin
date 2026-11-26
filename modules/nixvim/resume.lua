local token = vim.env.OSC7577_TOKEN
vim.env.OSC7577_TOKEN = nil
if not token then return end

local DIR = vim.fn.stdpath("state") .. "/sessions"
local MAX_AGE = 30 * 24 * 60 * 60

local function resumed_session()
	local argv = vim.v.argv
	for i = 1, #argv - 1 do
		if argv[i] == "-S" and vim.startswith(argv[i + 1], DIR .. "/") then return argv[i + 1] end
	end
end

local session = resumed_session() or ("%s/%d-%d.vim"):format(DIR, os.time(), vim.uv.os_getpid())

local function report(keys)
	-- This process is Neovim's server. The terminal runs its parent, the TUI.
	local body = ("pid=%d:time=%d:%s"):format(vim.uv.os_getppid(), os.time(), keys)
	vim.api.nvim_ui_send(("\27]7577;%s:mac=%s\27\\"):format(body, vim.fn.sha256(body .. ":" .. token)))
end

local argv = { "nvim", "-S", session }
for i, arg in ipairs(argv) do
	argv[i] = vim.base64.encode(arg)
end
local resume_argv = "argv=" .. table.concat(argv, ",")
report(resume_argv)

local group = vim.api.nvim_create_augroup("rex_resume", {})

-- A program run while Neovim was suspended may have replaced its record.
vim.api.nvim_create_autocmd("VimResume", {
	group = group,
	callback = function() report(resume_argv) end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = group,
	callback = function()
		for name in vim.fs.dir(DIR) do
			local path = DIR .. "/" .. name
			local stat = vim.uv.fs_stat(path)
			if stat and os.time() - stat.mtime.sec > MAX_AGE then os.remove(path) end
		end
		if vim.v.exiting == 0 then
			report("clear=1")
			os.remove(session)
		else
			vim.fn.mkdir(DIR, "p")
			vim.cmd.mksession({ session, bang = true })
		end
	end,
})
