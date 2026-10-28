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
      "magpie"
      "ollama-app"

      # Development
      "corretto@11" # for MATLAB
      "ghostty"
      "homebrew-app"
      "kitty"
      "markedit"
      # "neovide-app" # depends on nvim
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
      # "tinycast" # not in homebrew

      # System and hardware
      # "adguard" # use mini
      "istat-menus"
      "keyboardcleantool"
      # "little-snitch" # beta now
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
