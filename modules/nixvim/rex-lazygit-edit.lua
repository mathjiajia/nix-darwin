-- Run by Lazygit in its repository directory, without loading the user's config.
local channel = vim.fn.sockconnect("pipe", assert(vim.env.NVIM), { rpc = true })
assert(channel > 0, "Could not connect to the originating Neovim")
local file = vim.fn.fnamemodify(assert(arg[1], "Missing file to edit"), ":p")
vim.rpcrequest(channel, "nvim_exec_lua", "return require('rex-lazygit').edit(...)", {
	file,
	tonumber(arg[2]) or vim.NIL,
	vim.env.REX_BLOCK
})
vim.fn.chanclose(channel)
