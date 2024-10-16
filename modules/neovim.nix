{
  pkgs,
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
    withPython3 = false;
    withRuby = false;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      lz-n

      # coding
      {
        plugin = luasnip;
        optional = true;
      }
      {
        plugin = nvim-cmp;
        optional = true;
      }
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-rg
      cmp_luasnip
      mysnippets
      {
        plugin = copilot-lua;
        optional = true;
      }
      copilot-cmp
      {
        plugin = ultimate-autopair-nvim;
        optional = true;
      }
      {
        plugin = nvim-surround;
        optional = true;
      }

      # dap
      {
        plugin = nvim-dap;
        optional = true;
      }
      {
        plugin = nvim-dap-ui;
        optional = true;
      }
      nvim-dap-virtual-text
      nvim-nio

      # editor
      {
        plugin = oil-nvim;
        optional = true;
      }
      {
        plugin = grug-far-nvim;
        optional = true;
      }
      {
        plugin = fzf-lua;
        optional = true;
      }
      flash-nvim
      gitsigns-nvim
      quicker-nvim
      {
        plugin = aerial-nvim;
        optional = true;
      }

      # lang
      latex-nvim
      {
        plugin = markview-nvim;
        optional = true;
      }
      {
        plugin = lazydev-nvim;
        optional = true;
      }
      # {
      #   plugin = luvit-meta;
      #   optional = true;
      # }

      # lsp
      nvim-lspconfig
      mason-nvim
      # mason-tool-installer-nvim
      conform-nvim
      {
        plugin = nvim-lint;
        optional = true;
      }

      # ui
      {
        plugin = bamboo-nvim;
        optional = true;
      }
      nvim-notify
      dressing-nvim
      nvim-highlight-colors
      dropbar-nvim
      statuscol-nvim
      heirline-nvim
      indent-blankline-nvim
      noice-nvim
      dashboard-nvim
      {
        plugin = zen-mode-nvim;
        optional = true;
      }
      twilight-nvim
      rainbow-delimiters-nvim
      mini-icons

      # util
      {
        plugin = toggleterm-nvim;
        optional = true;
      }
      {
        plugin = resession-nvim;
        optional = true;
      }
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
            gitattributes
            gitcommit
            gitignore
            git_rebase
            html
            json
            jsonc
            latex
            lua
            luadoc
            luap
            nix
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
            yaml
          ]
        );
      }
    ];
  };

  #   xdg.configFile."nvim" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./config;
  #   };
}
