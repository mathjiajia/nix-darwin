{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
      extraEnv.HOMEBREW_NO_ANALYTICS = "1";
    };
    greedyCasks = true;

    casks = [
      # AI
      "chatgpt"
      "codex"
      "claude"
      "claude-code"
      "antigravity"
      "antigravity-cli"

      # Local LLM
      "llama-app"
      "lm-studio-bionic"
      "lobehub"
      "ollama-app"

      # Development
      "ghostty"
      "homebrew-app"
      "kitty"
      "orbstack"
      "orchard"

      "google-chrome"
      "markedit"
      # "markdown-preview"
      # "neovide"
      "visual-studio-code"
      "zed"

      "corretto@11" # for Matlab
      "sf-symbols"

      # Productivity
      "hazel"
      "hazeover"
      "keyboard-maestro"
      "launchbar"
      "loop"
      # "nutstore"
      # "raycast"
      # "tinycast"

      # System
      "adguard"
      # "airstats"
      "display-pilot"
      "istat-menus"
      "keka"
      "kekaexternalhelper"
      "keyboardcleantool"
      "mole-app"
      "omniwm"
      "onyx"
      "surge"
      "tailscale-app"

      # Quick Look
      "apparency"
      "syntax-highlight"

      # Media
      "downie"
      "iina"
      "permute"
      "sandisk"

      # Research
      "publish-or-perish"
      "quarto"
      "sage"
      "skim"
      "zotero"

      # Design
      "hhkb"
      "inkscape"

      # Communication
      "qq"
      "zoom"

      # Input
      "squirrel-app"

      # Fonts
      "font-mozilla-text"

      # Games
      "8bitdo-firmware-updater"
      "openra"
    ];
  };
}
