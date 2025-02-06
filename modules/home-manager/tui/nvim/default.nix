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
    ./users
    ./highlight
    ./lsp

    ./compiler
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./fmtlint.nix
    ./mini.nix
    ./snacks.nix
    ./treesitter.nix
    ./ui.nix

    ./extras.nix
    # ./nvzone.nix
  ];
}
