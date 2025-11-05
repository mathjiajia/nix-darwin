{
  programs.nixvim.plugins = {
    dap-python.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      adapters.executables.lldb-dap.command = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap";
      configurations =
        let
          lldb-launch = {
            name = "Debug";
            type = "lldb-dap";
            request = "launch";
            cwd = "\${workspaceFolder}";
            program = "\${workspaceFolder}/\${fileBasenameNoExtension}";
          };
          lldb-attach = {
            name = "Attach (wait)";
            type = "lldb-dap";
            request = "attach";
            program = "\${workspaceFolder}/\${fileBasenameNoExtension}";
            waitFor = true;
          };
          cpp-launch = lldb-launch // {
            preLaunchTask = "C/C++: clang build active file";
          };
          cpp-attach = lldb-attach // {
            preLaunchTask = "C/C++: clang build active file";
          };
          swift-launch = lldb-launch // {
            preLaunchTask = "swiftc: Build Debug";
          };
          swift-attach = lldb-attach // {
            preLaunchTask = "swiftc: Build Debug";
          };
        in
        {
          cpp = [
            cpp-launch
            cpp-attach
          ];
          c = [
            cpp-launch
            cpp-attach
          ];
          swift = [
            swift-launch
            swift-attach
          ];
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
  };

  programs.nixvim.extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>db";
      action = "<Cmd>DapToggleBreakpoint<CR>";
      options.desc = "Toggle [D]ebug [B]reakpoint";
    }
    {
      mode = "n";
      key = "<leader>dB";
      action.__raw = ''function() require("dap").set_breakpoint(vim.ui.input("Breakpoint condition: ")) end'';
      options.desc = "[B]reakpoint Condition";
    }
    {
      mode = "n";
      key = "<leader>dc";
      action = "<Cmd>DapContinue<CR>";
      options.desc = "[C]ontinue";
    }
    {
      mode = "n";
      key = "<leader>dg";
      action.__raw = ''function() require("dap").goto_() end'';
      options.desc = "[G]Go to Line (No Execute)";
    }
    {
      mode = "n";
      key = "<leader>di";
      action = "<Cmd>DapStepInto<CR>";
      options.desc = "Step [I]nto";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = ''function() require("dap").run_last() end'';
      options.desc = "Run [L]ast";
    }
    {
      mode = "n";
      key = "<leader>do";
      action = "<Cmd>DapStepOut<CR>";
      options.desc = "Step [O]ut";
    }
    {
      mode = "n";
      key = "<leader>dO";
      action = "<Cmd>DapStepOver<CR>";
      options.desc = "Step [O]ver";
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = "<Cmd>DapToggleRepl<CR>";
      options.desc = "Toggle [R]EPL";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>dw";
      action.__raw = ''function() require("dap.ui.widgets").hover() end'';
      options.desc = "[W]idgets";
    }
    {
      mode = "n";
      key = "<leader>du";
      action.__raw = ''function() require("dapui").toggle() end'';
      options.desc = "[D]ap [U]I";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>de";
      action.__raw = ''function() require("dapui").eval() end'';
      options.desc = "[E]val";
    }
  ];
}
