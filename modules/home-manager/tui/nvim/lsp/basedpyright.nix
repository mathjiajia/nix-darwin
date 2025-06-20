{pkgs, ...}: {
  programs.nixvim.lsp.servers.basedpyright = {
    enable = true;
    settings = {
      cmd = ["${pkgs.basedpyright}/bin/basedpyright-langserver" "--stdio"];
      filetypes = ["python"];
      root_markers = [
        "pyproject.toml"
        "setup.py"
        "setup.cfg"
        "requirements.txt"
        "Pipfile"
        "pyrightconfig.json"
        ".git"
      ];
      settings.basedpyright.analysis = {
        autoSearchPaths = true;
        useLibraryCodeForTypes = true;
        diagnosticMode = "openFilesOnly";
      };
      on_attach.__raw = ''
        function(client, bufnr)
        	local function set_python_path(path)
        		if client.settings then
        			client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
        		else
        			client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
        		end
        		client.notify('workspace/didChangeConfiguration', { settings = nil })
        	end

        	vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
        		client:exec_cmd({
        			command = 'basedpyright.organizeimports',
        			arguments = { vim.uri_from_bufnr(bufnr) },
        		})
        	end, {
        			desc = 'Organize Imports',
        		})

        	vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
        		desc = 'Reconfigure basedpyright with the provided python path',
        		nargs = 1,
        		complete = 'file',
        	})
        end
      '';
    };
  };
}
