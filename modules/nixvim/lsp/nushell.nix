{
  lsp.servers.nushell = {
    enable = true;
    package = null;
    config = {
      cmd = [
        "nu"
        "--lsp"
      ];
      filetypes = [ "nu" ];
    };
  };
}
