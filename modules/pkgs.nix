{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    onefetch
    ripgrep
    unrar
    cargo
    tree-sitter

    ripgrep
    tree

    fastfetch
    lazygit
    neovide
    python3
  ];
}
