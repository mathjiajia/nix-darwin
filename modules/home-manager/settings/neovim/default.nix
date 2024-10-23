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
    # lua51Packages.lua
    luajit
    luajitPackages.luarocks
    nodejs
    tree-sitter
  ];

  programs.nixvim.globals = {
    loaded_ruby_provider = 0; # Ruby
    loaded_perl_provider = 0; # Perl
    loaded_python_provider = 0; # Python 2
  };

  programs.nixvim.clipboard = {
    # Use system clipboard
    register = "unnamedplus";
  };

  programs.nixvim.colorschemes.nord.enable = true;

  # Import all your configuration modules here
  imports = [
    ./performance.nix

    ./options.nix
    ./keymaps.nix
    ./autocmds.nix

    # ./lazy.nix

    ./conform.nix
    ./compiler.nix
    ./completion.nix
    ./diagnostics.nix
    ./gitsigns.nix
    ./lang.nix
    ./lsp.nix
    ./treesitter.nix
    ./ui.nix

    ./after.nix
  ];

}
