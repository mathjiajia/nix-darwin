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
    python312Packages.debugpy
    python312Packages.ipython
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
    texlab
    # dap
    # linter
    commitlint
    markdownlint-cli2
    shellcheck
    # formatter
    bibtex-tidy
    black
    prettierd
    shfmt
    stylua
    # others
    libclang
    lldb_19
    # tectonic
  ];
}
