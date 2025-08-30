{
  programs.sioyek = {
    enable = true;
    config = {
      use_system_theme = "1";
      page_separator_width = "1";

      startup_commands = "toggle_custom_color";

      ui_font = "Mozilla Text";
      status_font = "Sarasa Term SC";

      custom_background_color = "#d5d6db";
      custom_text_color = "#1a1b26";

      page_separator_color = "#d5d6db";
      search_highlight_color = "#166775";
      status_bar_color = "#222436";
      status_bar_text_color = "#828bb8";
      ui_text_color = "#1a1b26";
      ui_selected_text_color = "#1a1b26";
      ui_background_color = "#cbccd1";
      ui_selected_background_color = "#9699a3";
      background_color = "#d5d6db";
      dark_mode_background_color = "#222436";
      visual_mark_color = "0.58823529 0.60000000 0.63921569 0.2";
      text_highlight_color = "#9699a3";
      link_highlight_color = "#34548a";
      synctex_highlight_color = "#343b58";
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
