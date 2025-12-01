{ lib, pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "bamboo";
      italic-text = "always";
    };
  };

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./bat-themes;
    onChange = "${lib.getExe pkgs.bat} cache --build";
  };
}
