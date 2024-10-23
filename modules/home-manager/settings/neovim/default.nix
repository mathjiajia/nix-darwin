{ neovim-nightly-overlay, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    vimdiffAlias = true;
    defaultEditor = true;
    luaLoader.enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.nixvim.extraPackages = with pkgs; [
    luajit
    luajitPackages.luarocks
    nodejs
    tree-sitter

    bibtex-tidy
    black
    prettierd
    shfmt
    stylua
  ];

  programs.nixvim.globals = {
    loaded_ruby_provider = 0; # Ruby
    loaded_perl_provider = 0; # Perl
    loaded_python_provider = 0; # Python 2

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
  programs.nixvim.colorschemes.nord.enable = true;

  imports = [
    ./performance.nix

    ./options.nix
    ./keymaps.nix
    ./autocmds.nix

    # ./lazy.nix

    ./conform.nix
    # ./compiler.nix
    ./completion.nix
    # ./dap.nix
    ./diagnostics.nix
    ./editor.nix
    ./gitsigns.nix
    ./lang.nix
    ./lsp.nix
    ./treesitter.nix
    ./ui.nix

    ./extra.nix

    ./after.nix
  ];

}
