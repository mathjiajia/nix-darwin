{config, ...}: {
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    # greedyCasks = true;

    taps = builtins.attrNames config.nix-homebrew.taps;

    casks = [
      "aerospace"
      "corretto@11"
      "chatgpt"
      "dash"
      "downie"
      "fcitx5"
      "ghostty"
      "hazel"
      "hazeover"
      "hookmark"
      "iina"
      "istat-menus"
      "jordanbaird-ice"
      "keka"
      "kekaexternalhelper"
      "keyboard-maestro"
      "keyboardcleantool"
      "launchbar"
      "loop"
      "markedit"
      "mathpix-snipping-tool"
      "microsoft-edge"
      "neovide"
      "ollama"
      "permute"
      "prettyclean"
      "publish-or-perish"
      "qlmarkdown"
      "raycast"
      "sf-symbols"
      "skim"
      "soulver"
      "surge"
      "syntax-highlight"
      "visual-studio-code"
      "zoom"
      "zotero"
    ];
  };
}
