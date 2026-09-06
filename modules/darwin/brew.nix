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
      "claude"
      "google-gemini"

      # Local LLM
      "antigravity"
      "llama-app"
      "lm-studio"
      "lobehub"
      "ollama-app"
      # "osaurus"

      # Development
      "ghostty"
      "orbstack"
      "orchard"
      "utm@beta"
      "warp"

      "google-chrome"
      "markedit"
      "markdown-preview"
      # "neovide"
      "visual-studio-code"
      "zed"

      "corretto@11" # for Matlab
      "dash"
      "sf-symbols"

      # Productivity
      "hazel"
      "hazeover"
      "keyboard-maestro"
      "launchbar"
      "loop"
      # "nutstore"
      "raycast"

      # System
      "adguard"
      "airstats"
      "display-pilot"
      # "istat-menus"
      "keka"
      "kekaexternalhelper"
      "keyboardcleantool"
      "mole-app"
      "omniwm"
      # "onyx"
      "surge"
      "tailscale-app"
      # "thaw"
      "vorssaint"

      # Quick Look
      "apparency"
      "syntax-highlight"

      # Media
      "downie"
      "permute"
      "iina"
      # "neteasemusic"

      # Research
      # "mathpix-snipping-tool"
      "publish-or-perish"
      "quarto"
      "sage"
      "skim"
      "zotero"

      # Design
      "inkscape"

      # Communication
      "discord"
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
