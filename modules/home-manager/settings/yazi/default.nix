{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "lf";
    initLua = # lua
      ''
        require("git"):setup()
        require("full-border"):setup()
      '';
  };
}
