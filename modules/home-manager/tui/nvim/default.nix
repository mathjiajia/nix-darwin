{
  home = {
    sessionVariables.MANPAGER = "nvim +Man!";
    shellAliases.nv = "nvim";
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    nixpkgs.config.allowUnfree = true;
    colorscheme = "bamboo";
    withPython3 = false;
    withRuby = false;
  };

  programs.nixvim.performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };

    combinePlugins = {
      enable = true;
      pathsToLink = [ "/luasnippets" ];
    };
  };

  imports = [
    ./users
    ./lsp

    ./ai.nix
    ./compiler
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
