{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    difftastic
    emacs
    fastfetch
    glow
    hugo
    lazygit
    nixfmt-rfc-style
    nodejs
    onefetch
    python3
    pandoc
    poppler
    ripgrep
    swift-format
    # tectonic
    tree
    tree-sitter
    unrar
  ];
}
