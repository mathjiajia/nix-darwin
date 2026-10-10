{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      # AI
      "antigravity"
      "antigravity-cli"
      "chatgpt"
      "codex"
      "claude"
      "claude-code"
      "lody"

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
      # "neovide-app"
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
      "raycast"
      "soulver-cli"
      # "tinycast"

      # System
      "adguard"
      "display-pilot"
      "istat-menus"
      # "keka"
      # "kekaexternalhelper"
      "keyboardcleantool"
      "mole-app"
      "omniwm"
      "onyx"
      "surge"
      "tailscale-app"

      # Quick Look
      "syntax-highlight"

      # Media
      "downie"
      "iina"
      "permute"
      "sandisk"

      # Research
      "pdf-expert"
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
