return {
	name = "swift: swiftc debug build",
	condition = { filetype = { "swift" } },
	builder = function ()
		local file = vim.fn.expand("%:p")
		local outfile = vim.fn.expand("%:p:r")
		return {
			cmd = { "/usr/bin/swiftc" },
			args = { "-g", file, "-o", outfile },
			components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" }
		}
	end
}
