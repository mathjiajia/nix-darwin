{
  programs.nixvim = {
    plugins.dap = {
      enable = true;
      # adapters = {
      #   executables = {
      #     cppdbg = {
      #       id = "cppdbg";
      #       command = "OpenDebugAD7";
      #     };
      #     lldb = {
      #       id = "cppdbg";
      #       command = "lldb-vscode";
      #     };
      #   };
      #   servers = {
      #     codelldb = {
      #       port = ''''${port}'';
      #       executable = {
      #         command = "codelldb";
      #         args = [
      #           "--port"
      #           ''''${port}''
      #         ];
      #       };
      #     };
      #   };
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

    extraConfigLua =
      # lua
      ''
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
        	dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
        	dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
        	dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
        	dapui.close()
        end
      '';

    keymaps = [
      {
        key = "<leader>db";
        action.__raw =
          # lua
          ''function() require("dap").toggle_breakpoint() end'';
        options.desc = "Toggle Breakpoint";
      }
      {
        key = "<leader>dB";
        action.__raw =
          # lua
          ''function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end'';
        options.desc = "Breakpoint Condition";
      }
      {
        key = "<leader>dc";
        action.__raw =
          # lua
          ''function() require("dap").continue() end'';
        options.desc = "Continue";
      }
      {
        key = "<leader>dg";
        action.__raw =
          # lua
          ''function() require("dap").goto_() end'';
        options.desc = "Go to Line (No Execute)";
      }
      {
        key = "<leader>di";
        action.__raw =
          # lua
          ''function() require("dap").step_into() end'';
        options.desc = "Step Into";
      }
      {
        key = "<leader>dl";
        action.__raw =
          # lua
          ''function() require("dap").run_last() end'';
        options.desc = "Run Last";
      }
      {
        key = "<leader>do";
        action.__raw =
          # lua
          ''function() require("dap").step_out() end'';
        options.desc = "Step Out";
      }
      {
        key = "<leader>dO";
        action.__raw =
          # lua
          ''function() require("dap").step_over() end'';
        options.desc = "Step Over";
      }
      {
        key = "<leader>dr";
        action.__raw =
          # lua
          ''function() require("dap").repl.toggle() end'';
        options.desc = "Toggle REPL";
      }
      {
        mode = ["n" "v"];
        key = "<leader>dw";
        action.__raw =
          # lua
          ''function() require("dap.ui.widgets").hover() end'';
        options.desc = "Widgets";
      }
      {
        key = "<leader>du";
        action.__raw =
          # lua
          ''function() require("dapui").toggle() end'';
        options.desc = "Dap UI";
      }
      {
        mode = ["n" "v"];
        key = "<leader>de";
        action.__raw =
          # lua
          ''function() require("dapui").eval() end'';
        options.desc = "Eval";
      }
    ];
  };
}
