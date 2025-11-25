{ lib, pkgs, ... }:
{
  lsp.servers.leanls = {
    enable = true;
    package = null;
    config = {
      cmd.__raw = ''
        function(dispatchers, config)
        	local cmd_cwd = config.cmd_cwd
        	if not cmd_cwd and config.root_dir and vim.uv.fs_realpath(config.root_dir) then
        		cmd_cwd = config.root_dir
        	end
        	local local_cmd = { "${lib.getExe' pkgs.elan "lake"}", "serve", "--", config.root_dir }
        	return vim.lsp.rpc.start(local_cmd, dispatchers, {
        		cwd = cmd_cwd,
        		env = config.cmd_env,
        		detached = config.detached,
        	})
        end
      '';
      filetypes = [ "lean" ];
      root_dir.__raw = ''
        function(bufnr, on_dir)
        	local fname = vim.api.nvim_buf_get_name(bufnr)
        	fname = vim.fs.normalize(fname)
        	-- check if inside lean stdlib
        	local stdlib_dir
        	do
        		local _, endpos = fname:find "/lean/library"
        		if endpos then
        			stdlib_dir = fname:sub(1, endpos)
        		end
        	end
        	if not stdlib_dir then
        		local _, endpos = fname:find "/lib/lean"
        		if endpos then
        			stdlib_dir = fname:sub(1, endpos)
        		end
        	end

        	on_dir(
        		vim.fs.root(fname, { "lakefile.toml", "lakefile.lean", "lean-toolchain" })
        		or stdlib_dir
        		or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
        	)
        end
      '';
      capabilities.lean.silentDiagnosticSupport = true;
      init_options.hasWidgets = true;
    };
  };
}
