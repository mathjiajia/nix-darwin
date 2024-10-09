{
  config,
  pkgs,
  lib,
  ...
}:
let
  fromGitHub =
    owner: repo: ref: hash:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = ref;
        sha256 = hash;
      };
    };

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      # coding

      # dap

      # editor
      gitsigns-nvim

      # lang

      # lsp

      # ui
      nvim-notify
      dressing-nvim
      nvim-highlight-colors
      indent-blankline-nvim

      # util

      # ai
      nui-nvim

      nvim-lspconfig
      conform-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp
      copilot-lua
      copilot-cmp
      luasnip
      cmp_luasnip
      nvim-surround

      # treesitter
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          bash
          bibtex
          c
          comment
          diff
          fish
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
      ))
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
