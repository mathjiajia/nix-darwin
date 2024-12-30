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

  programs.nixvim.extraPackages = [pkgs.luajit];

  programs.nixvim.performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };

    combinePlugins = {
      enable = true;
      pathsToLink = [
        "/copilot"
        "/luasnippets"
      ];
      # standalonePlugins = ["nvim-treesitter"];
    };
  };

  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix

    ./colorscheme.nix
    ./diagnostics.nix

    ./ai.nix
    ./conform.nix
    ./compiler.nix
    ./completion.nix
    # ./dap.nix
    ./editor.nix
    ./lint.nix
    ./lsp.nix
    ./mini.nix
    ./neo-tree.nix
    ./treesitter.nix
    ./ui.nix

    ./extra-plugins.nix
    # ./nvchad.nix

    ./extra-files.nix
  ];
}
