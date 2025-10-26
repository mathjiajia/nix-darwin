{ inputs, pkgs, ... }:
let
  blink-indent = pkgs.vimUtils.buildVimPlugin {
    name = "blink.indent";
    src = inputs.blink-indent;
    nvimSkipModules = [
      "blink.indent.static"
      "blink.indent.scope"
      "blink.indent.utils"
    ];
  };
in
{
  programs.nixvim.extraPlugins = [
    blink-indent
    pkgs.vimPlugins.blink-pairs
  ];

  programs.nixvim.extraConfigLua = ''
    require("vim._extui").enable({})

    local hl_groups = {
    	"BlinkPairsBlue",
    	"BlinkPairsYellow",
    	"BlinkPairsGreen",
    	"BlinkPairsTeal",
    	"BlinkPairsMagenta",
    	"BlinkPairsPurple",
    	"BlinkPairsOrange",
    }

    require("blink.indent").setup({ scope = { highlights = hl_groups } })
    require("blink.pairs").setup({
    	mappings = {
    		pairs = {
    			["'"] = {
    				{
    					"\'\'\'",
    					"\'\'\'",
    					when = function()
    						local cursor = vim.api.nvim_win_get_cursor(0)
    						local line = vim.api.nvim_get_current_line()
    						return line:sub(cursor[2] - 1, cursor[2]) == "\'\'"
    					end,
    					filetypes = { "python" },
    				},
    				{
    					"'",
    					enter = false,
    					space = false,
    					when = function()
    						local cursor = vim.api.nvim_win_get_cursor(0)
    						local char = vim.api.nvim_get_current_line():sub(cursor[2], cursor[2])
    						return not char:match("%w")
    							and (vim.bo.filetype ~= "rust" or char:match("[&<]"))
    							and not vim.list_contains({ "bib", "tex", "plaintex" }, vim.bo.filetype)
    					end,
    				},
    			},
    			["`"] = {
    				{
    					"```",
    					"```",
    					when = function()
    						local cursor = vim.api.nvim_win_get_cursor(0)
    						local line = vim.api.nvim_get_current_line()
    						return line:sub(cursor[2] - 1, cursor[2]) == "``"
    					end,
    					filetypes = { "markdown", "vimwiki", "rmarkdown", "rmd", "pandoc", "quarto", "typst" },
    				},
    				{ "`", "'", filetypes = { "bib", "latex", "tex" } },
    				{ "`", enter = false, space = false },
    			},
    		},
    	},
    	highlights = { groups = hl_groups },
    })
  '';
}
