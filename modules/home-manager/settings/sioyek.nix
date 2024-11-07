{
  programs.sioyek = {
    # enable = true;
    config = {
      use_system_theme = "1";
      use_custom_color_as_dark_system_theme = "1";
      page_separator_width = "1";

      startup_commands = "fit_to_page_width_smart";

      custom_background_color = "#252623";
      custom_text_color = "#f1e9d2";

      page_separator_color = "#252623";
      search_highlight_color = "#e2c792";
      status_bar_color = "#252623";
      status_bar_text_color = "#f1e9d2";
      ui_text_color = "#f1e9d2";
      ui_selected_text_color = "#f1e9d2";
      ui_background_color = "#2f312c";
      ui_selected_background_color = "#838781";
      background_color = "#252623";
      visual_mark_color = "0.52156863 0.57254902 0.53725490 0.2";
      text_highlight_color = "#838781";
      link_highlight_color = "#70c2be";
      synctex_highlight_color = "#f08080";
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
