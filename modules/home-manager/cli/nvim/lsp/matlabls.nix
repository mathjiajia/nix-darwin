{pkgs, ...}: {
  programs.nixvim.extraConfigLua =
    # lua
    ''
      vim.lsp.config("matlabls", {
      	cmd = { "${pkgs.matlab-language-server}/bin/matlab-language-server", "--stdio" },
      	filetypes = { "matlab" },
      	root_markers = { ".git" },
      	single_file_support = false,
      	settings = {
      		MATLAB = {
      			indexWorkspace = true,
      			installPath = "/Applications/MATLAB_R2024b.app",
      			matlabConnectionTiming = "onStart",
      			telemetry = false,
      		},
      	},
      })
    '';
}
