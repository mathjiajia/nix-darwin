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
    dropbar-nvim
    grug-far-nvim

    latex-nvim
    mysnippets
    nvim-treesitter-pairs
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("dropbar").setup()
      require("grug-far").setup({ headerMaxWidth = 80 })
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
  ];
}
