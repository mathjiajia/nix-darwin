{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "lf";
    initLua =
      # lua
      ''
        require("git"):setup()
        require("full-border"):setup()
      '';
  };
}
