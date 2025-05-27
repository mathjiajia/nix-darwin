{pkgs, ...}: {
  programs.nixvim.lsp.servers.matlab_ls = {
    enable = true;
    settings = {
      cmd = ["${pkgs.matlab-language-server}/bin/matlab-language-server" "--stdio"];
      filetypes = ["matlab"];
      root_dir.__raw = ''
        function(bufnr, on_dir)
        	local root_dir = vim.fs.root(bufnr, '.git')
        	on_dir(root_dir or vim.fn.getcwd())
        end
      '';
      settings.MATLAB = {
        indexWorkspace = true;
        installPath = "/Applications/MATLAB_R2025a";
        matlabConnectionTiming = "onStart";
        telemetry = false;
      };
    };
  };
}
