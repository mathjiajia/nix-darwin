{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.stateVersion = "24.05";

  programs.bat = {
    enable = true;
    config = {
      theme = "bamboo";
      italic-text = "always";
      style = "numbers,changes,header";
    };
  };

  # xdg.configFile."bat/themes" = {
  #   recursive = true;
  #   source = ./home-modules/bat-themes;
  #   onChange = "${lib.getExe pkgs.bat} cache --build";
  # };

  programs.git = {
    enable = true;
    userName = "Jia Jia";
    userEmail = "mathjiajia@outlook.com";
    extraConfig = {
      github.user = "mathyjiajia";
      init = {
        defaultBranch = "trunk";
      };
      diff = {
        external = "${pkgs.difftastic}/bin/difft";
      };
    };
  };
}
