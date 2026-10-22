{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      auto-update = "off";
      background-blur = "macos-glass-clear";
      background-opacity = 0.95;
      custom-shader = "shaders/cursor_neovide.glsl";
      font-family = "Maple Mono NR NF CN";
      font-size = 16;
      keybind = "global:cmd+backquote=toggle_quick_terminal";
      mouse-hide-while-typing = true;
      theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
      window-colorspace = "display-p3";
      window-title-font-family = "Maple Mono SL NF CN";
    };
  };
}
