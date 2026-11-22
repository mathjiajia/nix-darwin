{
  plugins = {
    dap-python.enable = true;
    dap-ui = {
      enable = true;
      callSetup = false;
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
          program = "\${fileDirname}/\${fileBasenameNoExtension}";
          lldb = preLaunchTask: [
            {
              type = "lldb-dap";
              request = "launch";
              name = "Dap Debug";
              cwd = "\${workspaceFolder}";
              inherit program preLaunchTask;
            }
            {
              type = "lldb-dap";
              request = "attach";
              name = "Dap Attach";
              waitFor = true;
              inherit program preLaunchTask;
            }
          ];
        in
        {
          c = lldb "C/C++: clang debug build";
          cpp = lldb "C/C++: clang debug build";
          swift = lldb "swift: swiftc debug build";
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
      key = "<leader>dc";
      action.__raw = "function() dap.continue() end";
      options.desc = "Start or [c]ontinue [d]ebugging";
    }
    {
      mode = "n";
      key = "<leader>dn";
      action.__raw = "function() dap.step_over() end";
      options.desc = "Step over to the [n]ext line";
    }
    {
      mode = "n";
      key = "<leader>di";
      action.__raw = "function() dap.step_into() end";
      options.desc = "Step [i]nto";
    }
    {
      mode = "n";
      key = "<leader>do";
      action.__raw = "function() dap.step_out() end";
      options.desc = "Step [o]ut";
    }
    {
      mode = "n";
      key = "<leader>dt";
      action.__raw = "function() dap.terminate() end";
      options.desc = "[T]erminate [d]ebug session";
    }

    {
      mode = "n";
      key = "<leader>db";
      action.__raw = "function() dap.toggle_breakpoint() end";
      options.desc = "Toggle [b]reakpoint";
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
      options.desc = "Set conditional [B]reakpoint";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = "function() dap.run_last() end";
      options.desc = "Run [l]ast [d]ebug configuration";
    }
    {
      mode = "n";
      key = "<leader>dr";
      action.__raw = "function() dap.repl.toggle() end";
      options.desc = "Toggle [d]ebug [R]EPL";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>dh";
      action.__raw = "function() require('dap.ui.widgets').hover() end";
      options.desc = "Inspect value in a [h]over window";
    }

    {
      mode = "n";
      key = "<leader>du";
      action.__raw = "function() dapui.toggle({ reset = true }) end";
      options.desc = "Toggle [d]ebugger [U]I";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>de";
      action.__raw = "function() dapui.eval() end";
      options.desc = "[E]valuate expression";
    }
  ];
}
