{
  programs.kitty = {
    enable = true;
    font = {
      name = "Sarasa Term SC";
      size = 17;
    };
    settings = {
      # include = "./themes/bamboo.conf";
      themeFile = "tokyo_night_moon";
      cursor_trail = 3;
      detect_urls = false;
      disable_ligatures = "cursor";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      macos_titlebar_color = "background";
      macos_option_as_alt = "left";
      macos_colorspace = "displayp3";
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font";
    };
  };
}
