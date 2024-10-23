{ ... }:
{
  programs.nixvim.plugins = {
    toggleterm = {
      enable = true;
      settings = {
        float_opts = {
          border = "rounded";
        };
        open_mapping = "[[<C-Bslash>]]";
      };
      luaConfig.post =
        # lua
        ''
          local Terminal = require("toggleterm.terminal").Terminal
          local float_opts = { width = vim.o.columns, height = vim.o.lines }

          local btop = Terminal:new({ cmd = "btop", hidden = true, direction = "float", float_opts = float_opts })
          local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            hidden = true,
            direction = "float",
            float_opts = float_opts,
          })

          vim.keymap.set({ "n", "t" }, "<leader>ti", function() btop:toggle() end)
          vim.keymap.set({ "n", "t" }, "<leader>tg", function() lazygit:toggle() end)
        '';
    };

    overseer = {
      # enable = true;
      settings = {
        dap = false;
        strategy = "toggleterm";
        templates = [
          "builtin"
          "user.builder"
          "user.runner"
        ];
      };
    };

    sniprun = {
      enable = true;
      settings = {
        display = [
          "VirtualTextOk"
          "VirtualTextErr"
          "Terminal"
        ];
        selected_interpreters = [
          "Generic"
          "Lua_nvim"
          "Python3_fifo"
        ];
        repl_enable = [
          "Bash_original"
          "Lua_nvim"
          "Python3_fifo"
          "R_original"
        ];
        interpreter_options = {
          Generic = {
            Swift_original = {
              supported_filetypes = [ "swift" ];
              extension = ".swift";
              interpreter = "swift";
              boilerplate_pre = "import Foundation";
            };
          };
        };
      };
    };
  };
}
