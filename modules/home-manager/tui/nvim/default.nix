{ inputs, pkgs, ... }:
{
  home = {
    sessionVariables.MANPAGER = "nvim +Man!";
    shellAliases.nv = "nvim";
  };

  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
    luaLoader.enable = true;
    nixpkgs.config.allowUnfree = true;
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
        "/luasnippets" # luasnip
        "/runtime/queries" # nvim-treesitter
        # "/queries_config" # math-conceal.nvim
      ];
    };
  };

  imports = [
    ./users
    ./lsp

    # ./colorscheme.nix
    ./compiler
    ./ai.nix
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./fmtlint.nix
    ./lang.nix
    ./treesitter.nix
    ./ui.nix

    ./extras.nix
  ];
}
