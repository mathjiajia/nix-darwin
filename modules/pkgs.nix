{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cargo
    difftastic
    glow
    hugo
    luajit
    nixfmt-rfc-style
    nodejs
    onefetch
    python3
    python312Packages.ipython
    # python312Packages.pip
    poppler
    # swift-format
    # tectonic
    tree
    tree-sitter
    unrar

    basedpyright
    lua-language-server
    matlab-language-server
    nil
    taplo
    texlab

    commitlint
    markdownlint-cli2
    shellcheck

    bibtex-tidy
    black
    prettierd
    shfmt
    stylua

    libclang
    # gdb
    lldb_19
  ];
}
