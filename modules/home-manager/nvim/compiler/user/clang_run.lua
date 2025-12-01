return {
	name = "C/C++: clang build and run",
	condition = { filetype = { "c", "cpp" } },
	builder = function()
		local outfile = vim.fn.expand("%:p:r")
		return {
			cmd = { outfile },
			components = {
				{ "dependencies", task_names = { "C/C++: clang build" } },
				{ "open_output", focus = true },
				"default",
			},
		}
	end,
}
