{
  extraFiles = {
    "after/ftplugin/checkhealth.lua".text = ''vim.bo.buflisted = false'';
    "after/ftplugin/man.lua".text = ''vim.bo.buflisted = false'';

    "after/ftplugin/gitcommit.lua".text =
      # lua
      ''
        vim.wo[0][0].spell = true
        vim.wo[0][0].colorcolumn = "72"
        vim.bo.textwidth = 72
      '';

    "after/ftplugin/help.lua".text =
      # lua
      ''
        vim.keymap.set("n", "q", function() vim.api.nvim_win_close(0, false) end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/lean.lua".text =
      # lua
      ''
        vim.diagnostic.config({
        	virtual_lines = false,
        	virtual_text = true,
        })
      '';

    "after/ftplugin/markdown.lua".text =
      # lua
      ''
        vim.wo[0][0].spell = true
        vim.wo[0][0].conceallevel = 2
        vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Correct Last Spelling" })
      '';

    "after/ftplugin/python.lua".text =
      # lua
      ''
        vim.bo.expandtab = true

        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
      '';

    "after/ftplugin/qf.lua".text =
      # lua
      ''
        vim.wo[0][0].scrolloff = 0
        vim.bo.buflisted = false
        vim.keymap.set("n", "q", function() vim.api.nvim_win_close(0, false) end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/bib.lua".text =
      # lua
      ''
        vim.wo[0][0].spell = true
        vim.wo[0][0].colorcolumn = "80"
      '';

    "after/ftplugin/tex.lua".text =
      # lua
      ''
        vim.wo[0][0].conceallevel = 2
        vim.wo[0][0].spell = true

        vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Correct Last Spelling" })

        local config = require("nvim-surround.config")
        require("nvim-surround").buffer_setup({
        	surrounds = {
        		['"'] = {
        			add = { "``", "\'\'" },
        			find = "``.-\'\'",
        			delete = "^(``)().-(\'\')()$",
        		},
        		["'"] = {
        			add = { "`", "'" },
        			find = "`.-'",
        			delete = "^(`)().-(')()$",
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
        		-- 	add = function()
        		-- 		local env = config.get_input("Enter an environment: ")
        		-- 		return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
        		-- 	end,
        		-- 	find = function()
        		-- 		return config.get_selection({
        		-- 			node = "generic_environment",
        		-- 		})
        		-- 	end,
        		-- 	delete = [[^(\begin%b{})().*(\end%b{})()$]],
        		-- 	change = {
        		-- 		target = [[^\begin{(.-)()%}.*\end{(.-)()}$]],
        		-- 		replacement = function()
        		-- 			local env = require("nvim-surround.config").get_input("Environment: ")
        		-- 			return { { env }, { env } }
        		-- 		end,
        		-- 	},
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
      '';
  };
}
