{
  lsp.servers.sourcekit = {
    enable = true;
    package = null;
    config = {
      cmd = [ "/usr/bin/sourcekit-lsp" ];
      filetypes = [ "swift" ];
      # Prefer the nearest Xcode project/workspace over nested Swift packages.
      root_dir.__raw = ''
        function(bufnr, on_dir)
        	local function is_xcode(name)
        		return vim.endswith(name, ".xcodeproj") or vim.endswith(name, ".xcworkspace")
        	end
        	on_dir(vim.fs.root(bufnr, {
        		"buildServer.json",
        		".bsp",
        		is_xcode,
        		"compile_commands.json",
        		"Package.swift",
        		".git",
        	}))
        end
      '';
      capabilities = {
        workspace.didChangeWatchedFiles.dynamicRegistration = true;
        textDocument.diagnostic = {
          dynamicRegistration = true;
          relatedDocumentSupport = true;
        };
      };
    };
  };
}
