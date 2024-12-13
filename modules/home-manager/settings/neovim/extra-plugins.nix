{pkgs, ...}: let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "master";
      sha256 = "hKF4yr8TR4ImpiW2vHaiPUcYz5MO3JgDWagwPRbYnS4=";
    };
  };

  latex-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "latex";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "latex.nvim";
      rev = "master";
      sha256 = "9RwMlelpXxZS054cE5OVP/PHOnP0I9GLfBqgVESi4xU=";
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
  # blink-cmp-copilot = pkgs.vimUtils.buildVimPlugin {
  #   name = "blink-cmp-copilot";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "giuxtaposition";
  #     repo = "blink-cmp-copilot";
  #     rev = "master";
  #     sha256 = "CL/JJP7x0MJMrItZUI3+YvClVX5ciqmaukqgyFEj2uw=";
  #   };
  # };
  # blink-ripgrep-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "blink-ripgrep-nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mikavilpas";
  #     repo = "blink-ripgrep.nvim";
  #     rev = "master";
  #     sha256 = "2vzEoi9taT96mXjFNf3GHyOoImQB/CXqY6zt/TeKXKA=";
  #   };
  # };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    dropbar-nvim

    latex-nvim
    mysnippets
    nvim-treesitter-pairs
    # blink-cmp-copilot
    # blink-ripgrep-nvim
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("dropbar").setup()
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
