{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    difftastic
    glow
    hugo
    luajit
    luajitPackages.luarocks
    nixfmt-rfc-style
    nodejs
    onefetch
    python3
    python312Packages.ipython
    poppler
    # swift-format
    tree
    tree-sitter
    unrar
  ];
}
