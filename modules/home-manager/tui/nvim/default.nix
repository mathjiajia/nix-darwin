{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
    luaLoader.enable = true;
    colorscheme = "bamboo";
  };

  programs.nixvim.performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };

    combinePlugins = {
      enable = true;
      pathsToLink = [
        "/copilot" # copilot-lua
        "/luasnippets" # luasnip
      ];
    };
  };

  imports = [
    ./users
    ./lsp

    ./compiler
    ./ai.nix
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./fmtlint.nix
    ./mini.nix
    ./snacks.nix
    ./treesitter.nix
    ./ui.nix

    ./extras.nix
  ];
}
