{pkgs, ...}: {
  programs.nixvim.lsp.servers.matlab_ls = {
    enable = true;
    package = pkgs.matlab-language-server;
    config = {
      cmd = ["${pkgs.matlab-language-server}/bin/matlab-language-server" "--stdio"];
      filetypes = ["matlab"];
      root_markers = [".git"];
      workspace_required = true;
      settings.MATLAB = {
        indexWorkspace = true;
        installPath = "/Applications/MATLAB_R2025a";
        matlabConnectionTiming = "onStart";
        telemetry = false;
      };
    };
  };
}
