{lib, ...}: let
  inherit (lib.generators) toKeyValue mkKeyValueDefault;
in {
  xdg.configFile."ghostty/config".text = toKeyValue {mkKeyValue = mkKeyValueDefault {} " = ";} {
    theme = "gruvbox";
    # custom-shader = "./shaders/tft.glsl";

    font-size = 24;
    font-family = "Sarasa Term SC";
    font-thicken = true;
    # adjust-cell-height = "20%";

    keybind = "global:super+grave_accent=toggle_quick_terminal";

    macos-titlebar-style = "hidden";
    mouse-hide-while-typing = true;
    macos-icon = "custom-style";
    macos-icon-ghost-color = "yellow";
    macos-icon-screen-color = "purple,maroon";
    window-colorspace = "display-p3";

    auto-update = "off";
  };
}
