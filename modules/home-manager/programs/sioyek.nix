{
  programs.sioyek = {
    enable = true;
    config = {
      page_separator_width = "1";

      use_system_theme = "1";
      use_custom_color_as_dark_system_theme = "1";

      status_font = "Maple Mono SL NF CN";
      status_bar_color = "#313244";

      ui_font = "Mozilla Text";
      ui_background_color = "#313244";

      custom_background_color = "#1e1e2e";
      custom_text_color = "#cdd6f4";
    };
    bindings = {
      prev_state = "<C-o>";
      synctex_under_cursor = "<C-j>";

      # scrolling
      screen_down = "<C-d>";
      screen_up = "<C-u>";

      # page flipping
      next_page = "J";
      previous_page = "K";
    };
  };
}
