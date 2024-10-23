{ pkgs, ... }:
{
  programs.nixvim.plugins.dap = {
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
}
