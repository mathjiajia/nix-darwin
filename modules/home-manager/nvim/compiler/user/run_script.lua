return {
	name = "run script",
	condition = { filetype = { "lua", "sh", "swift" } },
	builder = function()
		local file = vim.fn.expand("%:p")
		local cmd = { file }
		if vim.bo.filetype == "lua" then
			cmd = { "nvim", "-l", file }
		elseif vim.bo.filetype == "swift" then
			cmd = { "swift", file }
		end
		return { cmd = cmd }
	end,
}
