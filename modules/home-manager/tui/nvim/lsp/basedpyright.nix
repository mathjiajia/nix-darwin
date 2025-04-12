{pkgs, ...}: {
  programs.nixvim.extraFiles."lsp/basedpyright.lua".text =
    # lua
    ''
      return {
      	cmd = { "${pkgs.basedpyright}/bin/basedpyright-langserver", "--stdio" },
      	filetypes = { "python" },
      	root_markers = {
      		"pyproject.toml",
      		"setup.py",
      		"setup.cfg",
      		"requirements.txt",
      		"Pipfile",
      		"pyrightconfig.json",
      		".git",
      	},
      	settings = {
      		basedpyright = {
      			analysis = {
      				autoSearchPaths = true,
      				useLibraryCodeForTypes = true,
      				diagnosticMode = "openFilesOnly",
      			},
      		},
      	},
      	on_attach = function(client, bufnr)
      		local function organize_imports()
      			local params = { command = "basedpyright.organizeimports", arguments = { vim.uri_from_bufnr(0) } }
      			client:request("workspace/executeCommand", params, nil, 0)
      		end

      		local function set_python_path(path)
      			if client.settings then
      				client.settings.python =
      					vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
      			else
      				client.config.settings =
      					vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
      			end
      			client.notify("workspace/didChangeConfiguration", { settings = nil })
      		end

      		vim.api.nvim_buf_create_user_command(
      			bufnr,
      			"PyrightOrganizeImports",
      			organize_imports,
      			{ desc = "Organize Imports" }
      		)
      		vim.api.nvim_buf_create_user_command(
      			bufnr,
      			"PyrightSetPythonPath",
      			set_python_path,
      			{ nargs = 1, complete = "file", desc = "Reconfigure basedpyright with the provided python path" }
      		)
      	end,
      }
    '';
}
