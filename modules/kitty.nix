{ ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      name = "Iosevka Term";
      size = 20;
    };
    settings = {
      update_check_interval = 0;
      macos_option_as_alt = "left";
    };
    themeFile = "tokyo_night_night";
  };
}
