{ neovim-nightly-overlay, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
  };

  programs.nixvim.extraPackages = with pkgs; [
    luajit
    nodejs # for copilot.lua
    python312Packages.ipython # for REPL (overseer)

    commitlint
    markdownlint-cli2
    shellcheck

    bibtex-tidy
    black
    nixfmt-rfc-style
    prettierd
    shfmt
    stylua
  ];

  programs.nixvim.globals = {
    loaded_perl_provider = 0;
    loaded_python3_provider = 0;
    loaded_ruby_provider = 0;

    loaded_gzip = 1;
    loaded_matchit = 1;
    loaded_matchparen = 1;
    loaded_netrwPlugin = 1;
    loaded_remote_plugins = 1;
    loaded_shada_plugin = 1;
    loaded_spellfile_plugin = 1;
    loaded_tarPlugin = 1;
    loaded_tutor_mode_plugin = 1;
    loaded_zipPlugin = 1;
  };

  programs.nixvim.clipboard.register = "unnamedplus";
  # programs.nixvim.colorschemes.gruvbox.enable = true;

  imports = [
    ./performance.nix

    ./options.nix
    ./keymaps.nix
    ./autocmds.nix

    ./diagnostics.nix

    ./conform.nix
    ./compiler.nix
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./lint.nix
    ./lsp.nix
    ./neo-tree.nix
    ./treesitter.nix
    ./ui.nix

    ./extra-plugins.nix
    # ./nvchad.nix

    ./extra-files.nix
  ];

}
