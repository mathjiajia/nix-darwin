{pkgs, ...}: {
  programs.nixvim.extraPackages = [pkgs.python3Packages.ipython];

  programs.nixvim.plugins = {
    overseer = {
      enable = true;
      settings = {
        # strategy = "jobstart";
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
