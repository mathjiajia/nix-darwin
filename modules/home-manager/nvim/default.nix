{
  luaLoader.enable = true;
  colorscheme = "bamboo";
  withPython3 = false;
  withRuby = false;

  performance = {
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

  extraFiles."after/ftplugin".source = ./after_ftplugin;
}
