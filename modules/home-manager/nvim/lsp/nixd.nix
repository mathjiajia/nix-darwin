{ lib, pkgs, ... }:
{
  lsp.servers.nixd = {
    enable = true;
    config = {
      cmd = [ "${lib.getExe pkgs.nixd}" ];
      filetypes = [ "nix" ];
      root_markers = [
        "flake.nix"
        ".git"
      ];
      settings.nixd =
        let
          nix-darwin = ''(builtins.getFlake "/private/etc/nix-darwin").darwinConfigurations.Jias-MacBook-Pro.options'';
          home-manager = nix-darwin + ''.home-manager.users.type.getSubOptions []'';
        in
        {
          options = {
            nix-darwin.expr = nix-darwin;
            home-manager.expr = home-manager;
            # nixvim.expr = ''(${home-manager}).programs.nixvim.type.getSubOptions ["programs" "nixvim"]'';
          };
        };
    };
  };
}
