{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    greedyCasks = true;

    brews = [
      "mole"
      "utftex"
    ];

    casks = [
      "adguard"
      "adobe-acrobat-pro"
      "adobe-creative-cloud"
      "alma"
      "chatgpt-atlas"
      "chatgpt"
      # "chatwise"
      "cherry-studio"
      "codeedit"
      "corretto@11"
      "dash"
      "discord"
      "downie"
      "font-mozilla-text"
      "ghostty"
      "hazel"
      "hazeover"
      "hookmark"
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
      # "lobehub"
      "loop"
      "markedit"
      "mathpix-snipping-tool"
      # "miaoyan"
      # "neovide"
      "neteasemusic"
      "ollama-app"
      "onyx"
      "openra"
      "orbstack"
      # "osaurus"
      "permute"
      "prettyclean"
      "publish-or-perish"
      "qlmarkdown"
      "quarto"
      "raycast"
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
