{
  neovim-nightly-overlay,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
  };

  programs.nixvim.extraPackages = with pkgs; [
    hub
    luajit
    nodejs # for copilot.lua
    python312Packages.ipython # for REPL (overseer)

    vscode-extensions.vadimcn.vscode-lldb
    # vscode-extensions.ms-vscode.cpptools

    commitlint
    markdownlint-cli2
    shellcheck

    alejandra
    bibtex-tidy
    black
    prettierd
    shfmt
    stylua
  ];

  imports = [
    ./performance.nix

    ./options.nix
    ./keymaps.nix
    ./autocmds.nix

    ./colorscheme.nix
    ./diagnostics.nix

    ./conform.nix
    ./compiler.nix
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./lint.nix
    ./lsp.nix
    ./neo-tree.nix
    ./treesitter.nix
    ./ui.nix

    ./extra-plugins.nix
    # ./nvchad.nix

    ./extra-files.nix
  ];
}
