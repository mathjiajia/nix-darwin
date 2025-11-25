{ lib, pkgs, ... }:
{
  programs.neovide = {
    enable = true;
    package = null;
    settings = {
      frame = "transparent";
      icon = "/Users/jia/bin/neovide.icns";
      neovim-bin = "${lib.getExe pkgs.neovim-unwrapped}";
      font = {
        normal = [
          "Sarasa Term SC"
          "Symbols Nerd Font"
        ];
        size = 24;
      };
    };
  };
}
