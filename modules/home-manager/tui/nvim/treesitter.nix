{
  programs.nixvim.dependencies.tree-sitter.enable = true;
  programs.nixvim.plugins = {
    treesitter-context.enable = true;
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
  };
}
