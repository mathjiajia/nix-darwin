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
      "downie"
      "fcitx5"
      "ghostty"
      "hazel"
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
      # "neovide"
      "ollama"
      "permute"
      "prettyclean"
      "qlmarkdown"
      "raycast"
      "skim"
      "surge"
      "syntax-highlight"
      "visual-studio-code"
      "zoom"
      "zotero"
    ];
  };
}
