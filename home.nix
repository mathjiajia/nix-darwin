{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
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
