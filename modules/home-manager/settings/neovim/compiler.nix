{
  programs.nixvim.plugins = {
    toggleterm = {
      enable = true;
      settings = {
        float_opts.border = "rounded";
        highlights.Normal.guibg = "";
        open_mapping = "[[<C-Bslash>]]";
        shade_terminals = false;
      };
      luaConfig.post =
        # lua
        ''
          local Terminal = require("toggleterm.terminal").Terminal
          local float_opts = { width = vim.o.columns, height = vim.o.lines }
          local btop = Terminal:new({ cmd = "btop", hidden = true, direction = "float", float_opts = float_opts })
          vim.keymap.set({ "n", "t" }, "<leader>ti", function()
          	btop:toggle()
          end, { desc = "Toggle Btop" })
        '';
    };

    overseer = {
      enable = true;
      settings = {
        strategy = "toggleterm";
        templates = ["builtin" "user.builder" "user.runner"];
      };
    };

    sniprun = {
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
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>rf";
      action = "<Cmd>OverseerRun RunFile<CR>";
      options.silent = true;
      options.desc = "Run File";
    }
    {
      key = "<leader>rr";
      action = "<Cmd>OverseerRun OpenREPL<CR>";
      options.silent = true;
      options.desc = "Open REPL";
    }

    {
      mode = ["n" "v"];
      key = "<leader>rs";
      action = "<Plug>SnipRun";
      options.silent = true;
      options.desc = "Snip Run";
    }
  ];
}
