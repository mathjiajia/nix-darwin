{
  programs.ghostty = {
    enable = true;
    installBatSyntax = false;
    settings = {
      theme = "gruvbox";
      font-family = "Sarasa Term SC";
      font-size = 21;
      font-thicken = true;
      keybind = "global:cmd+grave_accent=toggle_quick_terminal";
      macos-icon = "custom-style";
      macos-icon-ghost-color = "yellow";
      macos-icon-screen-color = "purple,maroon";
      mouse-hide-while-typing = true;
      window-colorspace = "display-p3";
      window-title-font-family = "Maple Mono CN";
      auto-update = "off";
    };
    themes = {
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
    };
  };
}
