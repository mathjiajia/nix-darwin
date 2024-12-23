{
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
}
