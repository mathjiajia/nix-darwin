{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    # ./theme.nix
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    initLua =
      # lua
      ''
        require("git"):setup()
        require("full-border"):setup()
      '';
  };
}
