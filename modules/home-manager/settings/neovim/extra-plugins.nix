{pkgs, ...}: let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "master";
      hash = "sha256-5mHU0QtdMBtoUGBvKiFfNEn5T8MSzPWLOqmll2kWrMU=";
    };
  };

  latex-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "latex";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "latex.nvim";
      rev = "master";
      hash = "sha256-9RwMlelpXxZS054cE5OVP/PHOnP0I9GLfBqgVESi4xU=";
    };
  };

  slimline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "slimline";
    src = pkgs.fetchFromGitHub {
      owner = "sschleemilch";
      repo = "slimline.nvim";
      rev = "master";
      hash = "sha256-xVQWt1M9+gXvCTjQkQY6RQj9E/NYQorse7cFPcsMajw=";
    };
  };

  nvim-treesitter-pairs = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-pairs";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "nvim-treesitter-pairs";
      rev = "master";
      hash = "sha256-Nr8h0yUpJMfRx+VZ3Jf03p3tCeSc7JWiwtruqkjzzkw=";
    };
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    aerial-nvim
    bamboo-nvim
    dropbar-nvim
    grug-far-nvim
    nvim-highlight-colors
    resession-nvim
    ultimate-autopair-nvim

    latex-nvim
    mysnippets
    nvim-treesitter-pairs
    slimline-nvim
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("bamboo").setup({
      	transparent = not vim.g.neovide,
      	term_colors = false,
      })
      require("bamboo").load()
      require("slimline").setup({
      	spaces = { components = "", left = "", right = "" },
      	sep = { hide = { first = true, last = true }, left = "", right = "" },
      })
      require("dropbar").setup()
      require("grug-far").setup({ headerMaxWidth = 80 })
      require("nvim-highlight-colors").setup()
      require("resession").setup()
      require("ultimate-autopair").setup()

      require("aerial").setup({
      	backends = { "lsp", "treesitter", "markdown", "man" },
      	layout = { resize_to_content = false },
      	filter_kind = false,
      	show_guides = true,
      })
    '';

  programs.nixvim.keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>sr";
      action.__raw =
        # lua
        ''
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({ prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil } })
          end
        '';
      options.desc = "Search and Replace";
    }

    {
      key = "<leader>cs";
      action = "<Cmd>AerialToggle<CR>";
      options.desc = "Aerial (Symbols)";
    }

    {
      key = "<leader>ss";
      action.__raw =
        # lua
        ''
          function()
          	require("resession").save()
          end
        '';
      options.desc = "Save Session";
    }
    {
      key = "<leader>sl";
      action.__raw =
        # lua
        ''
          function()
          	require("resession").load()
          end
        '';
      options.desc = "Load Session";
    }
    {
      key = "<leader>sd";
      action.__raw =
        # lua
        ''
          function()
          	require("resession").delete()
          end
        '';
      options.desc = "Delete Session";
    }
  ];
}
