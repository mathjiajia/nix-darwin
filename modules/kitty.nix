{ ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableFishIntegration = true;
    };
    settings = {
      font = {
        name = "Maple Mono NF CN";
        size = 20;
      };
      update_check_interval = 0;
      themeFile = "bamboo";
    };

    extraConfig = builtins.concatStringsSep "\n" [
      ''
        background              #252623
        foreground              #f1e9d2
        selection_background    #5b5e5a
        selection_foreground    #f1e9d2

        cursor              #fff8f0
        cursor_text_color   #0f0800

        active_tab_background       #f1e9d2
        active_tab_foreground       #111210
        inactive_tab_background     #3a3d37
        inactive_tab_foreground     #5b5e5a

        color0  #1c1e1b
        color8  #5b5e5a

        color1  #e75a7c
        color9  #e75a7c

        color2  #8fb573
        color10 #8fb573

        color3  #dbb651
        color11 #dbb651

        color4  #57a5e5
        color12 #57a5e5

        color5  #aaaaff
        color13 #aaaaff

        color6  #70c2be
        color14 #70c2be

        color7  #f1e9dc
        color15 #fff8f0
      ''
    ];
  };
}
