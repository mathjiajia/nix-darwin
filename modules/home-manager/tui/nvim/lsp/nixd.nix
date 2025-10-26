{ pkgs, ... }:
{
  programs.nixvim.lsp.servers.nixd = {
    enable = true;
    config = {
      cmd = [ "${pkgs.nixd}/bin/nixd" ];
      filetypes = [ "nix" ];
      root_markers = [
        "flake.nix"
        ".git"
      ];
    };
  };
}
