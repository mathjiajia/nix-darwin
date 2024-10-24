{
  programs.fish.interactiveShellInit = # fish
    "fish_add_path /opt/homebrew/bin";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      "swift-format"
    ];

    casks = [
      "chatgpt"
      "dash"
      "downie"
      "font-codicon"
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
      "sublime-merge"
      "surge"
      "syntax-highlight"
      "zed"
      "zotero"
    ];

    masApps = {
      "Bear" = 1091189122;
      "Craft" = 1487937127;
      "DevHub" = 6476452351;
      "Dictionaries" = 1380563956;
      "Drafts" = 1435957248;
      "Dropover" = 1355679052;
      "Due" = 524373870;
      "FileFillet" = 6443969762;
      "GarageBand" = 682658836;
      "Goodnotes" = 1444383602;
      "iMovie" = 408981434;
      "Infuse" = 1136220934;
      "Keynote" = 409183694;
      "MarkMark" = 6475077023;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "Numbers" = 409203825;
      "OpenCat" = 6445999201;
      "Pages" = 409201541;
      "Playgrounds" = 1496833156;
      "Perplexity: Ask Anything" = 6714467650;
      "Reeder" = 6475002485;
      "SnippetsLab" = 1006087419;
      "Taio" = 1527036273;
      "Telegram" = 747648890;
      "TestFlight" = 899247664;
      "Things" = 904280696;
      "uBlacklist for Safari" = 1547912640;
      "Ulysses" = 1225570693;
      "UPDF" = 1619925971;
      "VidHub" = 1659622164;
      "VooV" = 1497685373;
      "WeChat" = 836500024;
      "WhatsApp" = 310633997;
      "Whisper Transcription" = 1668083311;
    };
  };
}
