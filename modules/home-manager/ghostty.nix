{lib, ...}: let
  inherit (lib.generators) toKeyValue mkKeyValueDefault;
in {
  xdg.configFile."ghostty/config".text = toKeyValue {mkKeyValue = mkKeyValueDefault {} " = ";} {
    theme = "gruvbox";
    font-family = "Sarasa Term SC";
    font-size = 21;
    font-thicken = true;
    mouse-hide-while-typing = true;
    macos-icon = "custom-style";
    macos-icon-ghost-color = "yellow";
    macos-icon-screen-color = "purple,maroon";
    keybind = "global:super+grave_accent=toggle_quick_terminal";
    window-colorspace = "display-p3";
    window-title-font-family = "Maple Mono CN";
    auto-update = "off";
  };
}
