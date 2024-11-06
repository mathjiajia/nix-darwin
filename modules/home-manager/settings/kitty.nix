{
  programs.kitty = {
    enable = false;
    shellIntegration.enableFishIntegration = true;
    font = {
      name = "IosevkaTerm Nerd Font Mono";
      size = 20;
    };
    settings = {
      update_check_interval = 0;
      macos_option_as_alt = "left";
    };
    themeFile = "VSCode_Dark";
  };
}
