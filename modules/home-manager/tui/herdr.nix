{
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      theme = {
        name = "catppuccin";
        auto_switch = true;
        light_name = "catppuccin-latte";
        dark_name = "catppuccin";
      };
      update.version_check = false;
      keys.command = [
        {
          key = "prefix+g";
          type = "popup";
          command = "lazygit";
          description = "run lazygit";
          width = "100%";
          height = "100%";
        }
      ];
    };
  };
}
