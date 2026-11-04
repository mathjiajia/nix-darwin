{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    initLua =
      # lua
      ''
        require("full-border"):setup({ set = "rounded" })
        require("git"):setup({ order = 1500 })
      '';
  };
}
