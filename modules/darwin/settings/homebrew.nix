{
  environment.systemPath = ["/opt/homebrew/bin"];
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = ["swift-format"];

    casks = [
      "chatgpt"
      "dash"
      "downie"
      "follow"
      "hazel"
      "hazeover"
      "hookmark"
      "istat-menus"
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
      "sioyek"
      "soulver"
      "squirrel"
      "sublime-merge"
      "surge"
      "syntax-highlight"
      "zed"
      "zotero"
    ];
  };
}
