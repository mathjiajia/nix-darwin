{ lib, pkgs, ... }:
{
  lsp.servers.marksman = {
    enable = true;
    config = {
      cmd = [
        "${lib.getExe pkgs.marksman}"
        "server"
      ];
      filetypes = [
        "markdown"
        "markdown.mdx"
      ];
      root_markers = [
        ".marksman.toml"
        ".git"
      ];
      single_file_support = true;
    };
  };
}
