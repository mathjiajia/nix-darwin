{ ... }:
{
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text = # ghostty
      ''
        theme = bamboo
        # theme = GruvboxDarkHard

        # shader
        # custom-shader = bloom.glsl
        # custom-shader = crt.glsl
        # custom-shader = gradient.glsl

        # fonts
        font-size = 24
        font-family = IosevkaTerm Nerd Font
        # font-family = ProggyClean Nerd Font
        # font-family = Maple Mono NF CN
        font-thicken = true
        # font-feature = cv01
        # font-feature = ss03
        # adjust-cell-height = 20%

        # mouse-hide-while-typing = true

        # Window style
        # background-opacity = 0.95
        # background-blur-radius = 20
        # window-height = 40
        # window-width = 219
        # window-step-resize = true
        # window-save-state = always
        window-title-font-family = Maple Mono NF CN
        window-colorspace = display-p3

        shell-integration = fish

        # quick-terminal-position = right
        keybind = global:super+grave_accent=toggle_quick_terminal

        # Enable ALT so it works
        macos-option-as-alt = left

        auto-update = check
      '';
  };
}
