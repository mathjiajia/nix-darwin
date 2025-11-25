{ lib, pkgs, ... }:
{
  lsp.servers.taplo = {
    enable = true;
    config = {
      cmd = [
        "${lib.getExe pkgs.taplo}"
        "lsp"
        "stdio"
      ];
      filetypes = [ "toml" ];
      root_markers = [
        ".taplo.toml"
        "taplo.toml"
        ".git"
      ];
    };
  };
}
