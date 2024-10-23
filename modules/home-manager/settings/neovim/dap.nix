{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.dap = {
      enable = true;
      extensions = {
        # dap-python = {
        #   enable = true;
        #   package = pkgs.python312Packages.debugpy;
        # };
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

    keymaps = [
      # { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      # { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      # { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      # { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      # { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      # { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      # { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      # { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      # { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      # { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets", mode = { "n", "v" } },
      # { "<leader>du", function() require("dapui").toggle() end, desc = "Dap UI" },
      # { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },

      {
        key = "<leader>db";
        action.__raw = # lua
          ''
            function()
              require("dap").toggle_breakpoint()
            end
          '';
        options.desc = "Toggle Breakpoint";
      }
      {
        key = "<leader>dB";
        action.__raw = # lua
          ''
            function()
              require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end
          '';
        options.desc = "Breakpoint Condition";
      }
      {
        key = "<leader>dc";
        action.__raw = # lua
          ''
            function()
              require("dap").continue()
            end
          '';
        options.desc = "Continue";
      }
      {
        key = "<leader>dg";
        action.__raw = # lua
          ''
            function()
              require("dap").goto_()
            end
          '';
        options.desc = "Go to Line (No Execute)";
      }
      {
        key = "<leader>di";
        action.__raw = # lua
          ''
            function()
              require("dap").step_into()
            end
          '';
        options.desc = "Step Into";
      }
      {
        key = "<leader>dl";
        action.__raw = # lua
          ''
            function()
              require("dap").run_last()
            end
          '';
        options.desc = "Run Last";
      }
      {
        key = "<leader>do";
        action.__raw = # lua
          ''
            function()
              require("dap").step_out()
            end
          '';
        options.desc = "Step Out";
      }
      {
        key = "<leader>dO";
        action.__raw = # lua
          ''
            function()
              require("dap").step_over()
            end
          '';
        options.desc = "Step Over";
      }
      {
        key = "<leader>dr";
        action.__raw = # lua
          ''
            function()
              require("dap").repl.toggle()
            end
          '';
        options.desc = "Toggle REPL";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>dw";
        action.__raw = # lua
          ''
            function()
              require("dap.ui.widgets").hover()
            end
          '';
        options.desc = "Widgets";
      }
      {
        key = "<leader>du";
        action.__raw = # lua
          ''
            function()
              require("dapui").toggle()
            end
          '';
        options.desc = "Dap UI";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>de";
        action.__raw = # lua
          ''
            function()
              require("dapui").eval()
            end
          '';
        options.desc = "Eval";
      }

    ];
  };
}
