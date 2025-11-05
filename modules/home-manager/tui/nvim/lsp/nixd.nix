{ lib, pkgs, ... }:
{
  programs.nixvim.extraPackages = [ pkgs.nixfmt-rfc-style ];
  programs.nixvim.lsp.servers.nixd = {
    enable = true;
    config = {
      cmd = [ "${lib.getExe pkgs.nixd}" ];
      filetypes = [ "nix" ];
      root_markers = [
        "flake.nix"
        ".git"
      ];
      nixd.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
    };
  };
}
