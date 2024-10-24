{ pkgs, ... }:
{
  imports = [
    ./plugins
    ./settings.nix
    ./keymap.nix
  ];

  home.packages = with pkgs; [
    mdcat
  ];
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    initLua = # lua
      ''
        require("git"):setup()
        require("full-border"):setup()
      '';
  };
}
