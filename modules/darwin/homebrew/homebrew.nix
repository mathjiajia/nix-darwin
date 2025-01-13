{
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = [
      "chatgpt"
      "dash"
      "downie"
      "follow"
      "ghostty"
      "hazel"
      "hazeover"
      "hookmark"
      "istat-menus"
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
      "sioyek"
      "soulver"
      "sublime-merge"
      "surge"
      "syntax-highlight"
    ];
  };
}
