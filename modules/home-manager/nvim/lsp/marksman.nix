{ lib, pkgs, ... }:
{
  lsp.servers.marksman = {
    enable = true;
    config = {
      cmd = [
        "${lib.getExe pkgs.marksman}"
        "server"
      ];
      filetypes = [ "markdown" ];
      root_markers = [
        ".marksman.toml"
        ".git"
      ];
    };
  };
}
