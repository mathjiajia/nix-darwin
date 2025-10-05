{
  programs.nixvim.plugins = {
    treesitter.enable = true;
    treesitter-context.enable = true;
  };

  programs.nixvim.autoCmd = [
    {
      event = "FileType";
      desc = "Enable Treesitter";
      callback.__raw = ''
        function(ev)
        	if not pcall(vim.treesitter.start, ev.buf) then
        		return
        	end
        	vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      '';
    }
  ];
}
