{
  programs.nixvim = {
    plugins = {
      dap-python.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap = {
        enable = true;
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
    };

    extraConfigLua =
      # lua
      ''
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        -- dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
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
        action.__raw = ''function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end'';
        options.desc = "Breakpoint Condition";
      }
      {
        key = "<leader>dc";
        action = "<Cmd>DapContinue<CR>";
        options.desc = "Continue";
      }
      {
        key = "<leader>dg";
        action.__raw = ''function() require("dap").goto_() end'';
        options.desc = "Go to Line (No Execute)";
      }
      {
        key = "<leader>di";
        action = "<Cmd>DapStepInto<CR>";
        options.desc = "Step Into";
      }
      {
        key = "<leader>dl";
        action.__raw = ''function() require("dap").run_last() end'';
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
        action.__raw = ''function() require("dap.ui.widgets").hover() end'';
        options.desc = "Widgets";
      }
      {
        key = "<leader>du";
        action.__raw = ''function() require("dapui").toggle() end'';
        options.desc = "Dap UI";
      }
      {
        mode = ["n" "v"];
        key = "<leader>de";
        action.__raw = ''function() require("dapui").eval() end'';
        options.desc = "Eval";
      }
    ];
  };
}
