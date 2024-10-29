{ pkgs, ... }:
let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "master";
      sha256 = "5mHU0QtdMBtoUGBvKiFfNEn5T8MSzPWLOqmll2kWrMU=";
    };
  };

  latex-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "latex";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "latex.nvim";
      rev = "master";
      sha256 = "IG0uKocxYBbvaYtrVMW3Qmp5lBw3r9tu5PeJZv34Se0=";
    };
  };

  nvim-treesitter-pairs = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-pairs";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "nvim-treesitter-pairs";
      rev = "master";
      sha256 = "Nr8h0yUpJMfRx+VZ3Jf03p3tCeSc7JWiwtruqkjzzkw=";
    };
  };
in
{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    bamboo-nvim
    dropbar-nvim
    grug-far-nvim
    resession-nvim
    ultimate-autopair-nvim
    aerial-nvim

    latex-nvim
    mysnippets
    nvim-treesitter-pairs
  ];

  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
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
        ''function() require("resession").save() end'';
      options.desc = "Save Session";
    }
    {
      key = "<leader>sl";
      action.__raw =
        # lua
        ''function() require("resession").load() end'';
      options.desc = "Load Session";
    }
    {
      key = "<leader>sd";
      action.__raw =
        # lua
        ''function() require("resession").delete() end'';
      options.desc = "Delete Session";
    }
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("bamboo").setup({
      	transparent = true,
      	term_colors = false,
      })
      require("bamboo").load()
      require("dropbar").setup()
      require("grug-far").setup({ headerMaxWidth = 80 })
      require("resession").setup()
      require("ultimate-autopair").setup()

      require("aerial").setup({
      	backends = { "lsp", "treesitter", "markdown", "man" },
      	layout = { resize_to_content = false },
      	filter_kind = false,
      	show_guides = true,
      })
    '';
}
