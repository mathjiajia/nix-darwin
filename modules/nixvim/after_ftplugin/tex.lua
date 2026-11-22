-- vim.wo[0][0].conceallevel = 2
-- Turn spell on after the first screen update; loading the spell file takes ~11 ms.
local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
vim.schedule(function ()
	if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
		vim.wo[win][0].spell = true
	end
end)

vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Correct previous misspelling" })

local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
	surrounds = {
		["'"] = {
			add = { "`", "'" },
			find = "`.-'",
			delete = "^(`)().-(')()$"
		},
		['"'] = {
			add = { "``", "''" },
			find = "``.-''",
			delete = "^(``)().-('')()$"
		},
		["c"] = {
			add = function ()
				local cmd = config.get_input("Enter a command: ")
				if not cmd or cmd == "" then
					return
				end
				return { { "\\" .. cmd .. "{" }, { "}" } }
			end,
			find = "\\%a+%b{}",
			delete = "^(\\%a+{)().-(})()$",
			change = {
				target = "^\\(%a+)(){.-}()()$",
				replacement = function ()
					local cmd = config.get_input("Enter a command: ")
					if not cmd or cmd == "" then
						return
					end
					return { { cmd }, { "" } }
				end
			}
		},
		["$"] = {
			add = { "\\(", "\\)" },
			find = "\\%(.-\\%)",
			delete = "^(\\%()().-(\\%))()$",
			change = {
				target = "^\\(%()().-(\\%))()$",
				replacement = function ()
					return { { "[", "\t" }, { "", "\\]" } }
				end
			}
		}
	}
})
