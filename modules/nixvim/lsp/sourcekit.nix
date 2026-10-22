{
  lsp.servers.sourcekit = {
    enable = true;
    package = null;
    config = {
      cmd = [ "/usr/bin/sourcekit-lsp" ];
      filetypes = [ "swift" ];
      root_markers = [
        "buildServer.json"
        ".bsp"
        "*.xcodeproj"
        "*.xcworkspace"
        "compile_commands.json"
        "Package.swift"
        ".git"
      ];
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
