{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "gruvbox";
      font-family = "Sarasa Term SC";
      font-size = 24;
      font-thicken = true;
      keybind = "global:super+grave_accent=toggle_quick_terminal";
      macos-icon = "custom-style";
      macos-icon-ghost-color = "yellow";
      macos-icon-screen-color = "purple,maroon";
      macos-titlebar-style = "hidden";
      mouse-hide-while-typing = true;
      window-colorspace = "display-p3";
      auto-update = "off";
    };
  };
}
