{
  homebrew.casks = [
    # Development
    "google-chrome"

    # System and hardware
    "8bitdo-firmware-updater"
    "display-pilot"
    "hhkb"
    "sf-symbols"

    # Productivity
    "hazeover"
    "soulver-cli"

    # Media and design
    "iina"
    "inkscape"

    # Browsers and communication
    "discord"
    "qq"
    "zoom"

    # Games
    "openra"
  ];

  programs.mas.packages = {
    # Development
    "Apple Configurator" = 1037126344;
    DevHub = 6476452351;
    DevTutor = 6471227008;
    SnippetsLab = 1006087419;
    "Swift Playground" = 1496833156;
    TestFlight = 899247664;

    # Notes and writing
    Bear = 1091189122;
    # Craft = 1487937127;
    # "Craft Web Clipper" = 6748613311;
    Goodnotes = 1444383602;

    # Documents and office
    Keynote = 361285480;
    "Microsoft Excel" = 462058435;
    "Microsoft PowerPoint" = 462062816;
    "Microsoft Word" = 462054704;
    Numbers = 361304891;
    Pages = 361309726;
    ScanScan = 1249901692;
    UPDF = 1619925971;

    # Productivity
    # Dropover = 1355679052;
    Soulver = 1508732804;

    # Communication
    Telegram = 747648890;
    VooV = 1497685373;
    WeChat = 836500024;
    WhatsApp = 310633997;

    # Media
    VidHub = 1659622164;
    "Whisper Transcription" = 1668083311;

    # Network
    "Net Magic" = 6757392404;
    Shadowrocket = 932747118;

    # Input
    CobraTyping = 6784869356;
  };
}
