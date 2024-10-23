{ pkgs, ... }:
let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "403258463f48930d876806b3591bb90c1cbdb8ab";
      sha256 = "PNwNGYY5tgsRBagjLpCsXFzlTLslswzYYk4Mtg9iRhs=";
    };
  };

  latex-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "latex";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "latex.nvim";
      rev = "6c0c7af22fbecb7bdc7f2a7a59e8c0a219a74d86";
      sha256 = "XRGq/EfSU00cSpdEWOLgdWige8b9YqvqbpVefs/+FFA=";
    };
  };

  quicker-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "quicker";
    src = pkgs.fetchFromGitHub {
      owner = "stevearc";
      repo = "quicker.nvim";
      rev = "183041a46d6c908eefb1c23ea02cce9c8f41256e";
      sha256 = "vhDXkE33NkiCs8PUB2PIzljaL15V3Ac62FRgnEZs06M=";
    };
  };

  nvim-treesitter-pairs = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-pairs";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "nvim-treesitter-pairs";
      rev = "77423fac578ea8ec00552e75f9a1b1b6fb5ae695";
      sha256 = "Nr8h0yUpJMfRx+VZ3Jf03p3tCeSc7JWiwtruqkjzzkw=";
    };
  };
in

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    dropbar-nvim
    grug-far-nvim
    heirline-nvim
    resession-nvim

    latex-nvim
    mysnippets
    nvim-treesitter-pairs
    quicker-nvim
  ];

  programs.nixvim.extraConfigLua = # lua
    ''
      require('dropbar').setup()
      require('grug-far').setup({ headerMaxWidth = 80 })
      require('resession').setup()

      require('quicker').setup({
        keys = {
          { '>', function() require('quicker').expand({ before = 2, after = 2, add_to_existing = true }) end, desc = 'Expand quickfix context' },
          { '<', function() require('quicker').collapse() end, desc = 'Collapse quickfix context' },
        }
      })
    '';
}
