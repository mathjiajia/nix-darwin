{ lib, pkgs, ... }: {
  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
      tabs = "2";
      theme-light = "Catppuccin Latte";
      theme-dark = "Catppuccin Mocha";
    };
  };

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./bat-themes;
    onChange = "${lib.getExe pkgs.bat} cache --build";
  };
}
