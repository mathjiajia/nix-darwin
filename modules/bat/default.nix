{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "bamboo";
      italic-text = "always";
      style = "numbers,changes,header";
    };
  };

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./bat-themes;
    onChange = "${pkgs.bat} cache --build";
  };

}
