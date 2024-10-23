{ ... }:
{
  programs.nixvim.performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins = {
      enable = true;
      pathsToLink = [
        "/copilot"
        "/luasnippets"
      ];
      standalonePlugins = [
        # "conform-nvim"
        # "overseer-nvim"
        "nvim-treesitter"
      ];
    };
  };
}
