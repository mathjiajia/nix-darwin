vim.wo[0][0].conceallevel = 2
vim.wo[0][0].spell = true

vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Correct Last Spelling" })

local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
	surrounds = {
		["'"] = {
			add = { "`", "'" },
			find = "`.-'",
			delete = "^(`)().-(')()$",
		},
		['"'] = {
			add = { "``", "''" },
			find = "``.-''",
			delete = "^(``)().-('')()$",
		},
		["c"] = {
			add = function()
				local cmd = config.get_input("Enter a command: ")
				return { { "\\" .. cmd .. "{" }, { "}" } }
			end,
			find = "\\%a+%b{}",
			delete = "^(\\%a+{)().-(})()$",
			change = {
				target = "^\\(%a+)(){.-}()()$",
				replacement = function()
					local cmd = config.get_input("Enter a command: ")
					return { { cmd }, { "" } }
				end,
			},
		},
		-- ["e"] = {
		-- add = function()
		-- 	local env = config.get_input("Enter an environment: ")
		-- 	return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
		-- end,
		-- find = function()
		-- 	return config.get_selection({ node = "generic_environment" })
		-- end,
		-- delete = [[^(\begin%b{})().*(\end%b{})()$]],
		-- change = {
		-- 	target = [[^\begin{(.-)()%}.*\end{(.-)()}$]],
		-- 	replacement = function()
		-- 		local env = require("nvim-surround.config").get_input("Environment: ")
		-- 		return { { env }, { env } }
		-- 	end,
		-- },
		-- },
		["$"] = {
			add = { "\\(", "\\)" },
			find = "\\%(.-\\%)",
			delete = "^(\\%()().-(\\%))()$",
			change = {
				target = "^\\(%()().-(\\%))()$",
				replacement = function()
					return { { "[", "\t" }, { "", "\\]" } }
				end,
			},
		},
	},
})
