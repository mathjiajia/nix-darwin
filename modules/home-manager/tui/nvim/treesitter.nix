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

  programs.nixvim.opts.foldexpr = "v:lua.vim.treesitter.foldexpr()";
  # programs.nixvim.autoCmd = [
  #   {
  #     event = "FileType";
  #     desc = "Enable Treesitter";
  #     callback.__raw =
  #       # lua
  #       ''
  #         function(ev)
  #         	if not pcall(vim.treesitter.start, ev.buf) then
  #         		return
  #         	end
  #         	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  #         	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  #         end
  #       '';
  #   }
  # ];
}
