{
  config,
  pkgs,
  ...
}: let
  nvchad-volt = pkgs.vimUtils.buildVimPlugin {
    name = "volt";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "volt";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
  nvchad-menu = pkgs.vimUtils.buildVimPlugin {
    name = "menu";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "menu";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
  nvchad-minty = pkgs.vimUtils.buildVimPlugin {
    name = "minty";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "minty";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
  nvchad-timerly = pkgs.vimUtils.buildVimPlugin {
    name = "timerly";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "timerly";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
  nvchad-showkeys = pkgs.vimUtils.buildVimPlugin {
    name = "showkeys";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "showkeys";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
in {
  programs.nixvim.globals.base46_cache = "${config.xdg.dataHome}/nvim/base46_cache/";

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
    base46
    nvchad-ui
    nvchad-volt
    nvchad-menu
    nvchad-minty
    nvchad-timerly
    nvchad-showkeys
  ];

  programs.nixvim.extraFiles = {
    "lua/chadrc.lua".text =
      # lua
      ''
        vim.keymap.set("n", "<RightMouse>", function()
        	vim.cmd.exec('"normal! \\<RightMouse>"')
        	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "gitsigns"
        	require("menu").open(options, { mouse = true })
        end, { desc = "Menu" })
        vim.keymap.set("n", "<C-t>", function()
        	require("menu").open("default")
        end, { desc = "Menu" })
        vim.keymap.set("n", "<leader>tm", function()
        	require("nvchad.themes").open()
        end, { desc = "Themes Picker" })

        local options = {
        	base46 = {
        		theme = "nord",
        		transparency = false,
        		theme_toggle = { "nord", "nord" },
        		integrations = {
        			"codeactionmenu",
        			"dap",
        			"markview",
        			"notify",
        			"nvshades",
        			"rainbowdelimiters",
        			"semantic_tokens",
        		},
        		hl_add = {
        			DashboardHeader = { fg = "yellow" },
        			DashboardFooter = { fg = "dark_purple", italic = true },
        			DashboardProjectTitle = { fg = "nord_blue" },
        			DashboardProjectIcon = { fg = "sun" },
        			DashboardMruTitle = { fg = "teal" },
        			DashboardFiles = { italic = true },
        			DashboardShortCutIcon = { fg = "vibrant_green" },
        		},
        	},
        	ui = { statusline = { order = { "mode", "file", "git", "%=", "diagnostics", "lsp", "cwd", "cursor" } } },
        	nvdash = {
        		header = {
        			[[                                                                       ]],
        			[[                                                                     ]],
        			[[       ████ ██████           █████      ██                     ]],
        			[[      ███████████             █████                             ]],
        			[[      █████████ ███████████████████ ███   ███████████   ]],
        			[[     █████████  ███    █████████████ █████ ██████████████   ]],
        			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        			[[                                                                       ]],
        			[[                                                                       ]],
        		},
        		buttons = {
        			{ txt = "  Find File", keys = "ff", cmd = "FzfLua files" },
        			{ txt = "  Recent Files", keys = "fo", cmd = "FzfLua oldfiles" },
        			{ txt = "  Live Grep", keys = "sg", cmd = "FzfLua live_grep" },
        			{ txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
        			{ txt = "  Cheatsheet", keys = "ch", cmd = "NvCheatsheet" },
        		},
        	},
        	term = {
        		winopts = { number = false, relativenumber = false },
        		float = { width = 1, height = 1, border = "rounded" },
        	},
        	lsp = { signature = true },
        	cheatsheet = { excluded_groups = { ":help", "Opens" } },
        }
        return options
      '';
  };
}
