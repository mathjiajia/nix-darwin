{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      # AI
      "chatgpt"
      "claude"
      "claude-code"
      "codex"
      "llama-app"
      "lm-studio-bionic"
      "lobehub"
      "ollama-app"

      # Development
      "corretto@11" # for MATLAB
      "ghostty"
      "homebrew-app"
      "kitty"
      "markedit"
      # "neovide-app"
      "orbstack"
      "orchard"
      "visual-studio-code"
      "zed"

      # Productivity
      "hazel"
      "keyboard-maestro"
      "launchbar"
      "loop"
      "soulver-cli"
      # "tinycast"

      # System and hardware
      "adguard"
      "istat-menus"
      "keyboardcleantool"
      "mole-app"
      "omniwm"
      "onyx"
      "sandisk"
      "surge"
      "syntax-highlight"
      "tailscale-app"

      # Research
      "pdf-expert"
      "quarto"
      "sage"
      "skim"
      "zotero"

      # Fonts
      "font-mozilla-text"
    ];
  };
}
