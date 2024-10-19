{ pkgs, ... }:
{
  home.packages = with pkgs; [
    basedpyright
    bibtex-tidy
    black
    cargo
    commitlint
    difftastic
    glow
    hugo
    libclang
    luajit
    luajitPackages.luarocks
    lua-language-server
    markdownlint-cli2
    matlab-language-server
    nil
    nixfmt-rfc-style
    nodejs
    onefetch
    python3
    python312Packages.ipython
    poppler
    prettierd
    shellcheck
    shfmt
    stylua
    # swift-format
    taplo
    # tectonic
    texlab
    tree
    tree-sitter
    unrar
  ];
}
