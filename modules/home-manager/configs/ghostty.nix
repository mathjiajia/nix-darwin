{
  home.file.ghostty = {
    target = ".config/ghostty/config";
    text =
      # ghostty
      ''
        theme = light:rose-pine-dawn,dark:rose-pine
        # custom-shader = ./shaders/bloom.glsl

        # fonts
        font-size = 24
        font-family = IosevkaTerm Nerd Font
        font-family = Sarasa T SC
        font-thicken = true
        # adjust-cell-height = 20%

        background-opacity = 0.95
        background-blur-radius = 20
        window-title-font-family = Maple Mono NF CN
        window-colorspace = display-p3

        shell-integration = fish

        keybind = global:super+grave_accent=toggle_quick_terminal

        # macos-titlebar-style = hidden
        # mouse-hide-while-typing = true
        macos-option-as-alt = left
      '';
  };
}
