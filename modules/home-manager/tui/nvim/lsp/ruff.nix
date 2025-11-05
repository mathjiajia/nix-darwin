{ lib, pkgs, ... }:
{
  programs.nixvim.lsp.servers.ruff = {
    enable = true;
    config = {
      cmd = [
        "${lib.getExe pkgs.ruff}"
        "server"
      ];
      filetypes = [ "python" ];
      root_markers = [
        "pyproject.toml"
        "ruff.toml"
        ".ruff.toml"
        ".git"
      ];
    };
  };
}
