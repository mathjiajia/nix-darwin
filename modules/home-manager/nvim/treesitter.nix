{
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      incremental_selection.enable = true;
      indent.enable = true;
    };
  };

  # autoGroups.treesitterFoldIndent = { };
  # autoCmd = [
  #   {
  #     event = "FileType";
  #     group = "treesitterFoldIndent";
  #     desc = "Enable Treesitter, Fold and Indent";
  #     callback.__raw = ''
  #       function(ev)
  #       	if not pcall(vim.treesitter.start, ev.buf) then
  #       		return
  #       	end
  #       	vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  #       	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  #       end
  #     '';
  #   }
  # ];
}
