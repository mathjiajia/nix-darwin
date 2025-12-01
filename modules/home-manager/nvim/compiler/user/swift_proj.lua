return {
	name = "swift: Build Debug (Project)",
	condition = { filetype = { "swift" } },
	builder = function()
		return {
			cwd = vim.fs.root(0, { "Package.swift", ".git" }),
			cmd = { "/usr/bin/swift" },
			args = { "test" },
			components = { { "on_output_quickfix", open_on_exit = "failure" } },
		}
	end,
}
