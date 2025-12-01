return {
	name = "latexmk",
	condition = { filetype = { "tex" } },
	builder = function()
		return {
			cmd = { "latexmk" },
			args = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
			components = {
				{ "on_output_quickfix", open_on_exit = "failure" },
				{ "default" },
			},
		}
	end,
}
