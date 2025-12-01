return {
	name = "C/C++: clang build",
	condition = { filetype = { "c", "cpp" } },
	builder = function()
		local file = vim.fn.expand("%:p")
		local outfile = vim.fn.expand("%:p:r")
		local compiler = vim.bo.filetype == "c" and "/usr/bin/clang" or "/usr/bin/clang++"
		return {
			cmd = { compiler },
			args = { file, "-o", outfile },
			components = {
				{ "on_output_quickfix", open_on_exit = "failure" },
				"default",
			},
		}
	end,
}
