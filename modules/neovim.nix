{
  pkgs,
  lib,
  neovim-nightly-overlay,
  ...
}:
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
      rev = "397969a09511b38c995b9a1335051e394f6bb5f3";
      sha256 = "PvAfStyPqaR5PKnMuq4mFXV0t3x+QWye9TcYreVtNdU=";
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

  code_runner-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "code_runner";
    src = pkgs.fetchFromGitHub {
      owner = "CRAG666";
      repo = "code_runner.nvim";
      rev = "dcedccbf969a0f3bc00db446172b4966e83101dd";
      sha256 = "xxW0ymsPmxLE45Z/TPTiah8K7SOYti78UyVTza3Z21g=";
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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      lz-n

      # coding
      luasnip
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-rg
      cmp_luasnip
      mysnippets
      copilot-cmp
      copilot-lua
      ultimate-autopair-nvim
      nvim-surround

      # dap
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-nio

      # editor
      oil-nvim
      grug-far-nvim
      fzf-lua
      flash-nvim
      gitsigns-nvim
      quicker-nvim
      aerial-nvim

      # lang
      latex-nvim
      markview-nvim
      lazydev-nvim
      luvit-meta

      # lsp
      nvim-lspconfig
      mason-nvim
      mason-tool-installer-nvim
      conform-nvim
      nvim-lint

      # ui
      bamboo-nvim
      nvim-notify
      dressing-nvim
      nvim-highlight-colors
      dropbar-nvim
      statuscol-nvim
      heirline-nvim
      indent-blankline-nvim
      noice-nvim
      dashboard-nvim
      zen-mode-nvim
      twilight-nvim
      rainbow-delimiters-nvim
      mini-icons

      # util
      toggleterm-nvim
      resession-nvim
      nui-nvim
      code_runner-nvim

      nvim-treesitter-pairs
      {
        plugin = nvim-treesitter.withPlugins (
          plugins: with plugins; [
            bash
            bibtex
            c
            comment
            diff
            fish
            html
            latex
            lua
            luadoc
            luap
            markdown
            markdown_inline
            matlab
            python
            query
            regex
            swift
            toml
            vim
            vimdoc
          ]
        );
      }
    ];
  };

  #   xdg.configFile."nvim" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./config;
  #   };
}
