{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      auto-update = "off";
      background-blur = "macos-glass-regular";
      background-opacity = 0.5;
      custom-shader = "shaders/cursor_smear_gradient.glsl";
      font-family = "Sarasa Term SC";
      font-size = 19;
      keybind = "global:cmd+grave_accent=toggle_quick_terminal";
      mouse-hide-while-typing = true;
      macos-titlebar-style = "tabs";
      shell-integration-features = "no-cursor";
      theme = "bamboo";
      window-colorspace = "display-p3";
      window-title-font-family = "Sarasa Term SC";
    };
    themes = {
      bamboo = {
        cursor-color = "#fff8f0";
        cursor-text = "#0f0800";
        foreground = "#f1e9d2";
        background = "#252623";
        selection-foreground = "#f1e9d2";
        selection-background = "#5b5e5a";
        palette = [
          "0=#1c1e1b"
          "8=#5b5e5a"

          "1=#e75a7c"
          "9=#e75a7c"

          "2=#8fb573"
          "10=#8fb573"

          "3=#dbb651"
          "11=#dbb651"

          "4=#57a5e5"
          "12=#57a5e5"

          "5=#aaaaff"
          "13=#aaaaff"

          "6=#70c2be"
          "14=#70c2be"

          "7=#f1e9dc"
          "15=#fff8f0"
        ];
      };
      # bamboo-light = {
      #   cursor-color = "#0f0800";
      #   cursor-text = "#fff8f0";
      #   foreground = "#3a4238";
      #   background = "#fafae0";
      #   selection-foreground = "#3a4238";
      #   selection-background = "#a1a7a0";
      #   palette = [
      #     "0=#dadac2"
      #     "8=#c7c7af"
      #
      #     "1=#c72a3c"
      #     "9=#c72a3c"
      #
      #     "2=#27850b"
      #     "10=#27850b"
      #
      #     "3=#a77b00"
      #     "11=#a77b00"
      #
      #     "4=#458588"
      #     "12=#458588"
      #
      #     "5=#8a4adf"
      #     "13=#8a4adf"
      #
      #     "6=#188a9e"
      #     "14=#188a9e"
      #
      #     "7=#3a4238"
      #     "15=#252623"
      #   ];
      # };
      # gruvdark-dark = {
      #   foreground = "#d6cfc4";
      #   background = "#1d2021";
      #   selection-background = "#665c54";
      #   selection-foreground = "#ebdbb2";
      #   cursor-color = "#ebdbb2";
      #   cursor-text = "#141617";
      #   split-divider-color = "#292929";
      #   palette = [
      #     "0=#595959"
      #     "8=#928374"
      #
      #     "1=#ea6962"
      #     "9=#ea6962"
      #
      #     "2=#a9b665"
      #     "10=#a9b665"
      #
      #     "3=#d8a657"
      #     "11=#d8a657"
      #
      #     "4=#7daea3"
      #     "12=#7daea3"
      #
      #     "5=#d3869b"
      #     "13=#d3869b"
      #
      #     "6=#89b482"
      #     "14=#89b482"
      #
      #     "7=#ebdbb2"
      #     "15=#ebdbb2"
      #   ];
      # };
      # gruvdark-light = {
      #   foreground = "#111111";
      #   background = "#F7F5EA";
      #   selection-background = "#B0B0A6";
      #   selection-foreground = "#101010";
      #   cursor-color = "#404040";
      #   cursor-text = "#EAE7E1";
      #   split-divider-color = "#4F4F4F";
      #   palette = [
      #     "0=#1B1B1B"
      #     "8=#111111"
      #
      #     "1=#9F0202"
      #     "9=#9F0202"
      #
      #     "2=#006C00"
      #     "10=#006C00"
      #
      #     "3=#AE5F05"
      #     "11=#AE5F05"
      #
      #     "4=#1E5A8B"
      #     "12=#1E5A8B"
      #
      #     "5=#910E79"
      #     "13=#910E79"
      #
      #     "6=#008B7F"
      #     "14=#008B7F"
      #
      #     "7=#111111"
      #     "15=#111111"
      #   ];
      # };
      # vscode = {
      #   background = "#1E1E1E";
      #   foreground = "#D4D4D4";
      #   cursor-color = "#D4D4D4";
      #
      #   selection-background = "#264F78";
      #   selection-foreground = "#ffffff";
      #
      #   palette = [
      #     "0=#1E1E1E"
      #     "1=#e75a7c"
      #     "2=#6A9955"
      #     "3=#DCDCAA"
      #     "4=#569CD6"
      #     "5=#C586C0"
      #     "6=#56B6C2"
      #     "7=#D4D4D4"
      #
      #     "8=#808080"
      #     "9=#e75a7c"
      #     "10=#6A9955"
      #     "11=#DCDCAA"
      #     "12=#569CD6"
      #     "13=#C586C0"
      #     "14=#56B6C2"
      #     "15=#D4D4D4"
      #   ];
      # };
    };
  };
}
