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
    ./users
    ./lsp

    ./colorscheme.nix
    ./compiler
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./fmtlint.nix
    ./lang.nix
    ./treesitter.nix
    ./ui.nix
  ];

  extraFiles."after/ftplugin".source = ./after_ftplugin;
}
