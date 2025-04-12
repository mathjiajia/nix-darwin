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
      "corretto@11"
      "chatgpt"
      "dash"
      "downie"
      "fcitx5"
      "ghostty"
      "hazel"
      "hazeover"
      "hookmark"
      "kekaexternalhelper"
      "keyboard-maestro"
      "keyboardcleantool"
      "launchbar"
      "markedit"
      "mathpix-snipping-tool"
      "microsoft-edge"
      "permute"
      "prettyclean"
      "publish-or-perish"
      "qlmarkdown"
      "sf-symbols"
      "soulver"
      "surge"
      "syntax-highlight"
      "visual-studio-code"
    ];
  };
}
