{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      theme = "tokyonight_moon";
      # background-opacity = 0.9;
      # background-blur = true;
      # custom-shader = "shaders/bloom040.glsl";
      font-family = "Sarasa Term SC";
      font-size = 19;
      font-thicken = true;
      mouse-hide-while-typing = true;
      macos-icon = "custom-style";
      macos-icon-ghost-color = "yellow";
      macos-icon-screen-color = "purple,maroon";
      keybind = "global:cmd+grave_accent=toggle_quick_terminal";
      window-colorspace = "display-p3";
      window-title-font-family = "Sarasa Term SC";
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
      bamboo-light = {
        cursor-color = "0f0800";
        cursor-text = "fff8f0";
        foreground = "3a4238";
        background = "fafae0";
        selection-foreground = "3a4238";
        selection-background = "a1a7a0";

        palette = [
          "0=#dadac2"
          "8=#c7c7af"

          "1=#c72a3c"
          "9=#c72a3c"

          "2=#27850b"
          "10=#27850b"

          "3=#a77b00"
          "11=#a77b00"

          "4=#458588"
          "12=#458588"

          "5=#8a4adf"
          "13=#8a4adf"

          "6=#188a9e"
          "14=#188a9e"

          "7=#3a4238"
          "15=#252623"
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
      kanagawa-paper-ink = {
        background = "1F1F28";
        foreground = "DCD&BA";
        cursor-color = "c4b28a";
        selection-background = "363646";
        selection-foreground = "9e9b93";

        palette = [
          "0=#393836"
          "1=#c4746e"
          "2=#699469"
          "3=#c4b28a"
          "4=#7eb3c9"
          "5=#a292a3"
          "6=#8ea49e"
          "7=#C8C093"
          "8=#aca9a4"
          "9=#cc928e"
          "10=#72a072"
          "11=#d4c196"
          "12=#698a9b"
          "13=#b4a7b5"
          "14=#96ada7"
          "15=#d5cd9d"
        ];
      };
      kanagawa-paper-canvas = {
        background = "e1e1de";
        foreground = "595b62";
        cursor-color = "618bb6";
        selection-background = "c4cbdc";
        selection-foreground = "858479";

        palette = [
          "0=#4c4c65"
          "1=#b35560"
          "2=#57786c"
          "3=#a67337"
          "4=#719ac2"
          "5=#ac7085"
          "6=#526c79"
          "7=#858479"
          "8=#5c5c75"
          "9=#c75f6b"
          "10=#618679"
          "11=#b67e3d"
          "12=#86aed7"
          "13=#b57e91"
          "14=#5d7a89"
          "15=#919084"
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
