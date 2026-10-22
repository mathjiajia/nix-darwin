return {
	condition = { filetype = { "swift" } },
	generator = function ()
		local root = vim.fs.root(0, { "Package.swift" })
		if not root then
			return "No Package.swift found"
		end

		return {
			{
				name = "swift: Test (Project)",
				builder = function ()
					return {
						cwd = root,
						cmd = { "/usr/bin/swift" },
						args = { "test" },
						components = { { "on_output_quickfix", open_on_exit = "failure" }, "default" }
					}
				end
			}
		}
	end
}
