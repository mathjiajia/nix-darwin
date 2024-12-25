{pkgs, ...}: let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "master";
      sha256 = "1kRxF9QuObu4BYBpSzo1gsCqMkNaqnDDCWaGm38BvR0=";
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

  blink-ripgrep-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "blink-ripgrep";
    src = pkgs.fetchFromGitHub {
      owner = "mikavilpas";
      repo = "blink-ripgrep.nvim";
      rev = "master";
      sha256 = "MXeoAFRVf6Y7Ni/KtSloFH79l9/+pfNCn4yR7fKBCsA=";
    };
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    dropbar-nvim

    blink-ripgrep-nvim
    latex-nvim
    mysnippets
    nvim-treesitter-pairs
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("dropbar").setup()
    '';
}
