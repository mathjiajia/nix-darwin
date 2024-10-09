{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    difftastic
    glow
    hugo
    nixfmt-rfc-style
    nodejs
    onefetch
    python3
    pandoc
    poppler
    swift-format
    # tectonic
    tree
    tree-sitter
    unrar
  ];
}
