{
  programs.nixvim.extraFiles = {
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
        vim.wo[0][0].spell = true
        vim.wo[0][0].conceallevel = 2

        vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Correct Last Spelling" })

        require("nvim-surround").buffer_setup({
        	surrounds = {
        		["c"] = {
        			add = function()
        				local cmd = require("nvim-surround.config").get_input("Command: ")
        				return { { "\\" .. cmd .. "{" }, { "}" } }
        			end,
        			find = function()
        				return require("nvim-surround.config").get_selection({
        					node = { "generic_command", "label_definition" },
        				})
        			end,
        			change = {
        				target = "^\\([^%{]*)().-()()$",
        				replacement = function()
        					local cmd = require("nvim-surround.config").get_input("Command: ")
        					return { { cmd }, {} }
        				end,
        			},
        			delete = function()
        				local sel = require("nvim-surround.config").get_selections({
        					char = "c",
        					pattern = "^(\\.-{)().-(})()$",
        				})
        				if sel then
        					return sel
        				end
        				return require("nvim-surround.config").get_selections({
        					char = "c",
        					pattern = "^(\\.*)().-()()$",
        				})
        			end,
        		},
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
        		["`"] = {
        			add = { "``", "\'\'" },
        			find = "``.-\'\'",
        			delete = "^(``)().-(\'\')()$",
        		},
        	},
        })
      '';
  };
}
