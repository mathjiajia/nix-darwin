{
  programs.nixvim = {
    plugins.sniprun = {
      enable = true;
      settings = {
        display = ["VirtualTextOk" "VirtualTextErr" "Terminal"];
        selected_interpreters = ["Generic" "Lua_nvim" "Python3_fifo"];
        repl_enable = ["Bash_original" "Lua_nvim" "Python3_fifo" "R_original"];
        interpreter_options.Generic.Swift_original = {
          supported_filetypes = ["swift"];
          extension = ".swift";
          interpreter = "swift";
          boilerplate_pre = "import Foundation";
        };
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>rs";
        action = "<Plug>SnipRun";
        options.silent = true;
        options.desc = "Snip Run";
      }

      {
        key = "<leader>rf";
        action = ":let b:caret=winsaveview() <CR> | :%SnipRun <CR>| :call winrestview(b:caret) <CR>";
        options.silent = true;
        options.desc = "Run File";
      }
    ];
  };
}
