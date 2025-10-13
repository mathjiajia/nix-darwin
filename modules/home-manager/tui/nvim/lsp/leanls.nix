{ pkgs, ... }:
{
  programs.nixvim.lsp.servers.leanls = {
    enable = true;
    config = {
      cmd.__raw = ''
        function(dispatchers, config)
        	local local_cmd = { "${pkgs.lean4}/bin/lake", "serve", "--", config.root_dir }
        	return vim.lsp.rpc.start(local_cmd, dispatchers)
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
    };
  };
}
