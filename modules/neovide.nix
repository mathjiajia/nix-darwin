{ config, lib, ... }:
{
  programs.neovide = {
    enable = true;
    settings = {
      fork = false;
      frame = "full";
      idle = true;
      maximized = false;
      neovim-bin = lib.getExe config.programs.neovim.finalPackage;
      no-multigrid = false;
      srgb = false;
      tabs = true;
      theme = "auto";
      title-hidden = true;
      vsync = true;
      wsl = false;

      font = {
        normal = [ "Iosevka Nerd Font" ];
        size = 24;
      };
    };
  };
}
