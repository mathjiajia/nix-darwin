{ lib, pkgs, ... }: {
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
          nix-darwin = ''(builtins.getFlake "/private/etc/nix-darwin").darwinConfigurations.mbp.options'';
          home-manager = nix-darwin + ".home-manager.users.type.getSubOptions []";
          nixvim = "(${nix-darwin}).home-manager.users.valueMeta.attrs.jia.configuration.options.programs.nixvim.valueMeta.configuration.options";
        in
        {
          options = {
            nix-darwin.expr = nix-darwin;
            home-manager.expr = home-manager;
            nixvim.expr = nixvim;
          };
        };
    };
  };
}
