return {
	name = "latexmk",
	condition = { filetype = { "tex" } },
	params = function ()
		return {
			file = {
				type = "string",
				desc = "Main TeX file",
				default = vim.fn.expand("%:p"),
				validate = function (file)
					return vim.fn.filereadable(file) == 1
				end
			}
		}
	end,
	builder = function (params)
		local file = vim.fn.fnamemodify(params.file, ":p")
		return {
			cwd = vim.fs.dirname(file),
			cmd = { "latexmk" },
			args = { "-interaction=nonstopmode", "-synctex=1", file },
			components = {
				{ "on_output_quickfix", open_on_exit = "failure" },
				{ "default" }
			}
		}
	end
}
