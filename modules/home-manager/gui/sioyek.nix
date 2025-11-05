{
  programs.sioyek = {
    enable = true;
    config = {
      use_system_theme = "1";
      page_separator_width = "1";

      ui_font = "Mozilla Text";
      status_font = "Sarasa Term SC";

      use_custom_color_as_dark_system_theme = "1";
      custom_background_color = "#252623";
      custom_text_color = "#f1e9d2";

      status_bar_color = "#383b35";
      status_bar_text_color = "#f1e9d2";
      ui_text_color = "#3a4238";
      ui_background_color = "#fafae0";
      ui_selected_text_color = "#3a4238";
      ui_selected_background_color = "#dadac2";
      dark_mode_background_color = "#252623";
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
