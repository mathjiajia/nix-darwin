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
      # ui
      nvim-notify
      dressing-nvim

      # basics
      indent-blankline-nvim
      gitsigns-nvim

      # ai
      nui-nvim

      # coding
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
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          bash
          diff
          fish
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          html
          json
          lua
          markdown
          markdown_inline
          nix
          python
          query
          regex
          toml
          vim
          vimdoc
          yaml
        ]
      ))
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
