{pkgs, ...}: {
  programs.nixvim.extraPackages = [pkgs.python312Packages.ipython];

  programs.nixvim.plugins = {
    overseer = {
      enable = true;
      lazyLoad.settings = {
        cmd = ["OverseerRun" "OverseerOpen"];
        keys = [
          {
            __unkeyed-1 = "<leader>rf";
            __unkeyed-2 = "<Cmd>OverseerRun RunFile<CR>";
            silent = true;
            desc = "Run File";
          }
          {
            __unkeyed-1 = "<leader>rr";
            __unkeyed-2 = "<Cmd>OverseerRun OpenREPL<CR>";
            silent = true;
            desc = "Run REPL";
          }
        ];
      };
      settings = {
        # strategy = "jobstart";
        templates = ["builtin" "user.builder" "user.runner"];
      };
    };

    sniprun = {
      enable = true;
      lazyLoad.settings = {
        keys = [
          {
            __unkeyed-1 = "<leader>rs";
            __unkeyed-2 = "<Plug>SnipRun";
            mode = ["n" "v"];
            silent = true;
            desc = "Snip Run";
          }
        ];
      };
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
}
