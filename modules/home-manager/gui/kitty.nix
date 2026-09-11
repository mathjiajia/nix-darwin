{
  programs.kitty = {
    enable = true;
    package = null;
    autoThemeFiles = {
      light = "Catppuccin-Latte";
      dark = "Catppuccin-Mocha";
      noPreference = "Catppuccin-Latte";
    };
    font = {
      name = "Maple Mono";
      size = 17;
    };
    settings = {
      cursor_trail = 3;
      copy_on_select = "yes";
      tab_bar_style = "custom";
      tab_fade = "0 0 0 0";
      tab_title_template = "{fmt.fg._415c6d}{fmt.bg.default}  {index}:{f'{title[:6]}…{title[-6:]}' if title[25:] else title}{' []' if layout_name == 'stack' else ''} ";
      active_tab_title_template = "{fmt.fg._83b6af}{fmt.bg.default}  {index}:{f'{title[:6]}…{title[-6:]}' if title[25:] else title}{' []' if layout_name == 'stack' else ''} ";
      tab_bar_edge = "top";
      tab_bar_margin_height = "10.0 0.0";
      bell_on_tab = "no";
      macos_titlebar_color = "background";
      macos_custom_beam_cursor = "yes";
      macos_option_as_alt = "yes";
      macos_show_window_title_in = "window";
      macos_colorspace = "displayp3";
      dynamic_background_opacity = "yes";
    };
  };
}
