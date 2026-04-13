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
      "adguard"
      "alma"
      "chatgpt-atlas"
      "chatgpt"
      "codeedit"
      "corretto@11"
      "codex-app"
      "dash"
      "discord"
      "downie"
      "font-mozilla-text"
      "ghostty"
      "google-gemini"
      "hazel"
      "hazeover"
      "iina"
      "inkscape"
      "istat-menus"
      "keka"
      "kekaexternalhelper"
      "keyboard-maestro"
      "keyboardcleantool"
      "launchbar"
      "llamabarn"
      "lm-studio"
      "lobehub"
      "loop"
      "markedit"
      "mathpix-snipping-tool"
      "mole-app"
      # "neovide"
      "neteasemusic"
      "ollama-app"
      "onyx"
      "openra"
      "orbstack"
      # "osaurus"
      "permute"
      "publish-or-perish"
      "qlmarkdown"
      "quarto"
      # "raycast"
      "sage"
      "sf-symbols"
      "skim"
      "soulver"
      "squirrel-app"
      "surge"
      "syntax-highlight"
      "thaw"
      "visual-studio-code"
      "warp"
      "zed"
      "zoom"
      "zotero"
    ];
  };
}
