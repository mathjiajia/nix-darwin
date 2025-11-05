{
  programs.nixvim = {
    plugins.sniprun = {
      enable = true;
      settings = {
        display = [
          "VirtualTextOk"
          "VirtualTextErr"
          "Terminal"
        ];
        selected_interpreters = [ "Python3_fifo" ];
        repl_enable = [
          "Python3_fifo"
          "Swift_original"
        ];
      };
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>rr";
        action = "<Plug>SnipRun";
        options.silent = true;
        options.desc = "[R]un Snip";
      }
      {
        mode = "n";
        key = "<leader>rf";
        action.__raw = ''
          function()
          	local caret = vim.fn.winsaveview()
          	vim.cmd("%SnipRun")
          	vim.fn.winrestview(caret)
          end
        '';
        options.silent = true;
        options.desc = "[R]un [F]ile";
      }
      {
        mode = "n";
        key = "<leader>rm";
        action = "<Plug>SnipReplMemoryClean";
        options.desc = "[R]EPL [M]emory Clean";
      }
    ];
  };
}
