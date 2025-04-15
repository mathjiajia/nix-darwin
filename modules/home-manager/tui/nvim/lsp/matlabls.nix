{pkgs, ...}: {
  programs.nixvim.extraFiles."lsp/matlabls.lua".text =
    # lua
    ''
      return {
      	cmd = { "${pkgs.matlab-language-server}/bin/matlab-language-server", "--stdio" },
      	filetypes = { "matlab" },
      	root_markers = { ".git" },
      	workspace_required = true,
      	settings = {
      		MATLAB = {
      			indexWorkspace = true,
      			installPath = "/Applications/MATLAB_R2024b.app",
      			matlabConnectionTiming = "onStart",
      			telemetry = false,
      		},
      	},
      }
    '';
}
