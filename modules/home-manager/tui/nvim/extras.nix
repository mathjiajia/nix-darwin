{
  inputs,
  pkgs,
  ...
}: let
  fff-nvim = inputs.fff-nvim.packages.${pkgs.system}.fff-nvim;

  blink-indent = pkgs.vimUtils.buildVimPlugin {
    name = "blink.indent";
    src = inputs.blink-indent;
    nvimSkipModules = [
      "blink.indent.static"
      "blink.indent.scope"
      "blink.indent.utils"
    ];
  };
  # math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "math-conceal";
  #   src = inputs.math-conceal-nvim;
  #   patches = [./fix-math-conceal.patch];
  # };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    name = "latex-conceal";
    src = inputs.nvim-latex-conceal;
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    name = "math-snippets";
    src = inputs.nvim-math-snippets;
    nvimSkipModules = [
      "math-snippets.position"
      "math-snippets.context"
      "math-snippets.latex"
    ];
  };
  slimline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "slimline";
    src = inputs.slimline-nvim;
    nvimSkipModules = [
      "slimline.components.diagnostics"
      "slimline.components.filetype_lsp"
      "slimline.components.mode"
      "slimline.components.path"
      "slimline.components.progress"
      "slimline.components.recording"
      "slimline.components.searchcount"
      "slimline.components.selectioncount"
    ];
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    blink-pairs

    fff-nvim
    blink-indent
    # math-conceal-nvim
    nvim-latex-conceal
    nvim-math-snippets
    slimline-nvim
  ];

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = ''function() require("fff").find_files() end'';
      options.desc = "Open File Picker";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = ''function() require("fff").find_in_git_root() end'';
      options.desc = "Find Git Files";
    }
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("vim._extui").enable({ msg = { target = "msg" } })

      vim.g.fff = {
      	lazy_sync = true,
      	layout = { prompt_position = "top" },
      }

      local hl_groups = {
      	"BlinkPairsBlue",
      	"BlinkPairsYellow",
      	"BlinkPairsGreen",
      	"BlinkPairsTeal",
      	"BlinkPairsMagenta",
      	"BlinkPairsPurple",
      	"BlinkPairsOrange",
      }

      -- require("math-conceal").setup({
      -- 	conceal = {
      -- 		"greek",
      -- 		"script",
      -- 		"math",
      -- 		"font",
      -- 		"delim",
      -- 	},
      -- })
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

      require("blink.indent").setup({ scope = { highlights = hl_groups } })

      require("slimline").setup({
      	components = { center = { "searchcount", "selectioncount" } },
      	configs = {
      		mode = {
      			format = {
      				["n"] = { short = "NOR" },
      				["v"] = { short = "VIS" },
      				["V"] = { short = "V-L" },
      				["\22"] = { short = "V-B" },
      				["s"] = { short = "SEL" },
      				["S"] = { short = "S-L" },
      				["\19"] = { short = "S-B" },
      				["i"] = { short = "INS" },
      				["R"] = { short = "REP" },
      				["c"] = { short = "CMD" },
      				["r"] = { short = "PRO" },
      				["!"] = { short = "SHE" },
      				["t"] = { short = "TER" },
      				["U"] = { short = "UNK" },
      			},
      		},
      		git = { hl = { primary = "Function" } },
          progress = { column = true },
      	},
      })
    '';
}
