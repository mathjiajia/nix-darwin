{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    fastfetch
    lazygit
    neovide
    nodejs
    onefetch
    python3
    ripgrep
    tree
    tree-sitter
    unrar
  ];
}
