{
  plugins = {
    dap-python.enable = true;
    dap-ui = {
      enable = true;
      luaConfig.post = ''
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
      '';
    };
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      adapters.executables.lldb-dap.command = "/Applications/Xcode.app/Contents/Developer/usr/bin/lldb-dap";
      configurations =
        let
          lldb-launch = {
            type = "lldb-dap";
            request = "launch";
            name = "Dap Debug";
            cwd = "\${workspaceFolder}";
            program = "\${workspaceFolder}/\${fileBasenameNoExtension}";
          };
          lldb-attach = {
            type = "lldb-dap";
            request = "attach";
            name = "Dap Attach";
            program = "\${workspaceFolder}/\${fileBasenameNoExtension}";
            waitFor = true;
          };
          cpp-launch = lldb-launch // {
            preLaunchTask = "C/C++: clang debug build";
          };
          cpp-attach = lldb-attach // {
            preLaunchTask = "C/C++: clang debug build";
          };
          swift-launch = lldb-launch // {
            preLaunchTask = "swift: swiftc debug build";
          };
          swift-attach = lldb-attach // {
            preLaunchTask = "swift: swiftc debug build";
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
          linehl = "";
          numhl = "DapBreakpoint";
          text = "󰙧";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          linehl = "DapBreakpointCondition";
          numhl = "DapBreakpointCondition";
          text = "";
          texthl = "DapBreakpointCondition";
        };
        dapBreakpointRejected = {
          numhl = "";
          text = "";
          texthl = "DapBreakpointRejected";
        };
        dapLogPoint = {
          numhl = "";
          text = "";
          texthl = "DapLogPoint";
        };
        dapStopped = {
          linehl = "DapStopped";
          numhl = "DapStopped";
          text = "";
          texthl = "DapStopped";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<F5>";
      action.__raw = "function() dap.continue() end";
      options.desc = " Start/Continue";
    }
    {
      mode = "n";
      key = "<F10>";
      action.__raw = "function() dap.step_over() end";
      options.desc = " Step over";
    }
    {
      mode = "n";
      key = "<F11>";
      action.__raw = "function() dap.step_into() end";
      options.desc = " Step into";
    }
    {
      mode = "n";
      key = "<F12>";
      action.__raw = "function() dap.step_out() end";
      options.desc = " Step out";
    }

    {
      mode = "n";
      key = "<leader>db";
      action.__raw = "function() dap.toggle_breakpoint() end";
      options.desc = "[D]ap Toggle [B]reakpoint";
    }
    {
      mode = "n";
      key = "<leader>dB";
      action.__raw = ''
        function()
        	vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
        		if not input or input == "" then
        			return vim.notify("No condition provided", vim.log.levels.WARN)
        		end
        		return dap.set_breakpoint(input)
        	end)
        end
      '';
      options.desc = "[D]AP Conditional [B]reakpoint";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = "function() dap.run_last() end";
      options.desc = "[D]ap Run [L]ast";
    }
    {
      mode = "n";
      key = "<leader>dr";
      action.__raw = "function() dap.repl.toggle() end";
      options.desc = "[D]ap Toggle [R]EPL";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>dh";
      action.__raw = "function() require('dap.ui.widgets').hover() end";
      options.desc = "[D]ap Widgets [H]over";
    }

    {
      mode = "n";
      key = "<leader>du";
      action.__raw = "function() dapui.toggle({ reset = true }) end";
      options.desc = "[D]ap Toggle [U]I";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>de";
      action.__raw = "function() dapui.eval() end";
      options.desc = "[D]ap UI [E]val";
    }
  ];
}
