{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "bamboo";
      # background-opacity = 0.9;
      # background-blur = true;
      custom-shader = "shaders/bloom040.glsl";
      font-family = "Sarasa Term SC";
      font-size = 23;
      font-thicken = true;
      mouse-hide-while-typing = true;
      macos-icon = "custom-style";
      macos-icon-ghost-color = "yellow";
      macos-icon-screen-color = "purple,maroon";
      keybind = "global:cmd+grave_accent=toggle_quick_terminal";
      window-colorspace = "display-p3";
      window-title-font-family = "Maple Mono NF CN";
      auto-update = "off";
    };
    themes = {
      bamboo = {
        cursor-color = "fff8f0";
        cursor-text = "0f0800";
        foreground = "f1e9d2";
        background = "252623";
        selection-foreground = "f1e9d2";
        selection-background = "5b5e5a";
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
      gruvbox = {
        cursor-color = "ebdbb2";
        background = "1d2021";
        foreground = "ebdbb2";
        selection-background = "665c54";
        selection-foreground = "ebdbb2";
        palette = [
          "0=#595959"
          "8=#928374"

          "1=#ea6962"
          "9=#ea6962"

          "2=#a9b665"
          "10=#a9b665"

          "3=#d8a657"
          "11=#d8a657"

          "4=#7daea3"
          "12=#7daea3"

          "5=#d3869b"
          "13=#d3869b"

          "6=#89b482"
          "14=#89b482"

          "7=#ebdbb2"
          "15=#ebdbb2"
        ];
      };
      vscode = {
        background = "1E1E1E";
        foreground = "D4D4D4";
        cursor-color = "D4D4D4";

        selection-background = "264F78";
        selection-foreground = "ffffff";

        palette = [
          "0=#1E1E1E"
          "1=#e75a7c"
          "2=#6A9955"
          "3=#DCDCAA"
          "4=#569CD6"
          "5=#C586C0"
          "6=#56B6C2"
          "7=#D4D4D4"

          "8=#808080"
          "9=#e75a7c"
          "10=#6A9955"
          "11=#DCDCAA"
          "12=#569CD6"
          "13=#C586C0"
          "14=#56B6C2"
          "15=#D4D4D4"
        ];
      };
    };
  };
}
