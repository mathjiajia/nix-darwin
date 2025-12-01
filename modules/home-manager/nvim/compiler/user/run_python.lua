return {
	name = "run python",
	condition = { filetype = { "python" } },
	builder = function()
		local file = vim.fn.expand("%:p")
		local root = vim.fs.root(file, { "pyproject.toml", ".venv" })
		local cmd

		if root then
			cmd = { "uv", "run" }
		else
			cmd = { "python" }
		end

		return {
			cmd = cmd,
			args = { file },
			components = {
				{ "open_output", focus = true },
				"default",
			},
		}
	end,
}
