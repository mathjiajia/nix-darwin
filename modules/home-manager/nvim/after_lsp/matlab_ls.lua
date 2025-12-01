return {
	cmd = { "matlab-language-server", "--stdio" },
	filetypes = { "matlab" },
	root_dir = function(bufnr, on_dir)
		local root_dir = vim.fs.root(bufnr, ".git")
		on_dir(root_dir or vim.fn.getcwd())
	end,
	settings = {
		MATLAB = {
			indexWorkspace = true,
			installPath = "/Applications/MATLAB_R2025a.app",
			matlabConnectionTiming = "onStart",
			telemetry = true,
		},
	},
}
