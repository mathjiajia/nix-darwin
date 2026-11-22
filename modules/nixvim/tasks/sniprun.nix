{
  plugins.sniprun = {
    enable = true;
    settings = {
      display = [
        "VirtualText"
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
        "x"
      ];
      key = "<leader>rr";
      action = "<Plug>SnipRun";
      options.silent = true;
      options.desc = "[R]un line or selection";
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
      options.desc = "[R]un current [f]ile";
    }
    {
      mode = "n";
      key = "<leader>rm";
      action = "<Plug>SnipReplMemoryClean";
      options.desc = "Clear snippet REPL [m]emory";
    }
  ];
}
