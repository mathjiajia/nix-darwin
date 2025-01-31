{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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

    ./hl_bamboo.nix
    # ./hl_catppuccin.nix
    # ./hl_vscode.nix
    ./diagnostics.nix

    ./ai.nix
    ./conform.nix
    ./compiler.nix
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./lint.nix
    ./lsp.nix
    ./mini.nix
    ./snacks.nix
    ./treesitter.nix
    ./ui.nix

    ./extra-plugins.nix
    # ./nvzone.nix

    ./extra-files.nix
  ];
}
