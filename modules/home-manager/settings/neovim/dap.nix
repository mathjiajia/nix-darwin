{pkgs, ...}: {
  programs.nixvim = {
    # extraPackages = [pkgs.vscode-extensions.vadimcn.vscode-lldb];
    plugins = {
      dap = {
        enable = true;
        # lazyLoad.settings = {
        #   cmd = ["DapToggleBreakpoint"];
        #   keys = [
        #     {
        #       __unkeyed-1 = "<leader>db";
        #       __unkeyed-2 = "<Cmd>DapToggleBreakpoint<CR>";
        #       desc = "Toggle Breakpoint";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>dB";
        #       __unkeyed-2.__raw =
        #         # lua
        #         ''
        #           function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end
        #         '';
        #       desc = "Breakpoint Condition";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>dc";
        #       __unkeyed-2 = "<Cmd>DapContinue<CR>";
        #       desc = "Continue";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>dg";
        #       __unkeyed-2.__raw =
        #         # lua
        #         ''
        #           function() require("dap").goto_() end
        #         '';
        #       desc = "Go To Line (No Execute)";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>di";
        #       __unkeyed-2 = "<Cmd>DapStepInto<CR>";
        #       desc = "Step Into";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>dl";
        #       __unkeyed-2.__raw =
        #         # lua
        #         ''
        #           function() require("dap").run_last() end
        #         '';
        #       desc = "Run Last";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>do";
        #       __unkeyed-2 = "<Cmd>DapStepOut<CR>";
        #       desc = "Step Out";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>dO";
        #       __unkeyed-2 = "<Cmd>DapStepOver<CR>";
        #       desc = "Step Over";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>dr";
        #       __unkeyed-2 = "<Cmd>DapToggleRepl<CR>";
        #       desc = "Toggle REPL";
        #     }
        #     {
        #       mode = ["n" "v"];
        #       __unkeyed-1 = "<leader>dw";
        #       __unkeyed-2.__raw =
        #         # lua
        #         ''
        #           function() require("dap.ui.widgets").hover() end
        #         '';
        #       desc = "Widgets";
        #     }
        #     {
        #       __unkeyed-1 = "<leader>du";
        #       __unkeyed-2.__raw =
        #         # lua
        #         ''
        #           function() require("dapui").toggle() end
        #         '';
        #       desc = "Dap UI";
        #     }
        #     {
        #       mode = ["n" "v"];
        #       __unkeyed-1 = "<leader>de";
        #       __unkeyed-2.__raw =
        #         # lua
        #         ''
        #           function() require("dapui").eval() end
        #         '';
        #       desc = "Eval";
        #     }
        #   ];
        # };
        extensions = {
          dap-python.enable = true;
          dap-ui.enable = true;
          dap-virtual-text.enable = true;
        };
        signs = {
          dapBreakpoint = {
            numhl = "";
            text = " ";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            numhl = "";
            text = " ";
            texthl = "DapBreakpointCondition";
          };
          dapBreakpointRejected = {
            numhl = "";
            text = " ";
            texthl = "DapBreakpointRejected";
          };
          dapLogPoint = {
            numhl = "";
            text = ".>";
            texthl = "DapLogPoint";
          };
          dapStopped = {
            numhl = "";
            text = "󰁕 ";
            texthl = "DapStopped";
          };
        };
      };
      # dap-lldb = {
      #   enable = true;
      #   settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      # };
    };

    extraConfigLua =
      # lua
      ''
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
      '';

    keymaps = [
      {
        key = "<leader>db";
        action = "<Cmd>DapToggleBreakpoint<CR>";
        options.desc = "Toggle Breakpoint";
      }
      {
        key = "<leader>dB";
        action.__raw =
          # lua
          ''
            function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end
          '';
        options.desc = "Breakpoint Condition";
      }
      {
        key = "<leader>dc";
        action = "<Cmd>DapContinue<CR>";
        options.desc = "Continue";
      }
      {
        key = "<leader>dg";
        action.__raw =
          # lua
          ''
            function() require("dap").goto_() end
          '';
        options.desc = "Go to Line (No Execute)";
      }
      {
        key = "<leader>di";
        action = "<Cmd>DapStepInto<CR>";
        options.desc = "Step Into";
      }
      {
        key = "<leader>dl";
        action.__raw =
          # lua
          ''
            function() require("dap").run_last() end
          '';
        options.desc = "Run Last";
      }
      {
        key = "<leader>do";
        action = "<Cmd>DapStepOut<CR>";
        options.desc = "Step Out";
      }
      {
        key = "<leader>dO";
        action = "<Cmd>DapStepOver<CR>";
        options.desc = "Step Over";
      }
      {
        key = "<leader>dr";
        action = "<Cmd>DapToggleRepl<CR>";
        options.desc = "Toggle REPL";
      }
      {
        mode = ["n" "v"];
        key = "<leader>dw";
        action.__raw =
          # lua
          ''
            function() require("dap.ui.widgets").hover() end
          '';
        options.desc = "Widgets";
      }
      {
        key = "<leader>du";
        action.__raw =
          # lua
          ''
            function() require("dapui").toggle() end
          '';
        options.desc = "Dap UI";
      }
      {
        mode = ["n" "v"];
        key = "<leader>de";
        action.__raw =
          # lua
          ''
            function() require("dapui").eval() end
          '';
        options.desc = "Eval";
      }
    ];
  };
}
