{ pkgs, ... }: {
  luaLoader.enable = true;
  withPython3 = false;
  withRuby = false;
  extraPackages = [ pkgs.tree-sitter ];

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
    ./core
    ./lsp

    ./colorscheme.nix
    ./tasks
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./format-and-lint.nix
    ./extra-plugins.nix
    ./treesitter.nix
    ./ui.nix
  ];

  extraFiles."after/ftplugin".source = ./after_ftplugin;
}
