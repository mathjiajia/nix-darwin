{
  programs.nixvim.extraFiles = {
    "after/ftplugin/checkhealth.lua".text = ''vim.opt_local.buflisted = false'';
    "after/ftplugin/grug-far.lua".text = ''vim.opt_local.buflisted = false'';
    "after/ftplugin/man.lua".text = ''vim.opt_local.buflisted = false'';

    "after/ftplugin/help.lua".text =
      # lua
      ''
        vim.keymap.set("n", "q", function()
        	vim.api.nvim_win_close(0, false)
        end, { buffer = 0, silent = true, desc = "Quit buffer" })
      '';

    "after/ftplugin/markdown.lua".text =
      # lua
      ''
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true
        vim.keymap.set("i", "<C-h>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Crect Last Spelling" })
      '';

    "after/ftplugin/qf.lua".text =
      # lua
      ''
        vim.opt_local.buflisted = false
        vim.keymap.set("n", "q", function()
        	vim.api.nvim_win_close(0, false)
        end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/tex.lua".text =
      # lua
      ''
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true
        vim.keymap.set("i", "<C-h>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Crect Last Spelling" })
      '';
  };
}
