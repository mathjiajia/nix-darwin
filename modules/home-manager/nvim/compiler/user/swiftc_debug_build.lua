return {
	name = "swift: swiftc debug build",
	condition = { filetype = { "swift" } },
	builder = function()
		local file = vim.fn.expand("%:p")
		return {
			cmd = { "/usr/bin/swiftc" },
			args = { "-g", file },
			components = { { "on_output_quickfix", open_on_exit = "failure" } },
		}
	end,
}
