{ inputs, pkgs, ... }:
let
  nvim-treesitter = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-treesitter";
    src = inputs.nvim-treesitter;
    nvimSkipModules = [ "nvim-treesitter._meta.parsers" ];
  };
in
{

  programs.nixvim.dependencies.tree-sitter.enable = true;
  programs.nixvim.extraPlugins = [ nvim-treesitter ];

  # programs.nixvim.plugins = {
  # treesitter.enable = true;
  # treesitter-context.enable = true;
  # };

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
