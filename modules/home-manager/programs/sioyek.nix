{
  programs.sioyek = {
    enable = true;
    config = {
      page_separator_width = "1";

      use_system_theme = "1";
      use_custom_color_as_dark_system_theme = "1";

      status_font = "Maple Mono SL NF CN";
      status_bar_color = "#2f312c";

      ui_font = "Mozilla Text";
      ui_background_color = "#2f312c";

      custom_background_color = "#252623";
      custom_text_color = "#f1e9d2";
    };
    bindings = {
      prev_state = "<C-o>";
      next_state = "<C-i>";
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
