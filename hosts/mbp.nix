{
  # Settings specific to mbp.
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew.casks = [
    # AI
    "llama-app"
    "t3-code"

    # Development
    "ghostty"
    "google-chrome"
    "homebrew-app"
    "kitty"

    # System and hardware
    "8bitdo-firmware-updater"
    "display-pilot"
    "hhkb"
    "open-screnn-sharing"
    "sf-symbols"

    # Productivity
    "hazeover"
    "raycast"
    "soulver-cli"

    # Media and design
    "downie"
    "iina"
    "inkscape"
    "paper-design"
    "permute"

    # Browsers and communication
    # "discord"
    "qq"
    "swiftcord"
    "zoom"

    # Input
    "squirrel-app"

    # Games
    "openra"
  ];

  programs.mas.packages = {
    # Development
    "Apple Configurator" = 1037126344;
    Codye = 1516894961;
    "Swift Playground" = 1496833156;
    TestFlight = 899247664;

    # Reading and reference
    Readest = 6738622779;
    xcz = 912139104;

    # Communication
    Telegram = 747648890;
    VooV = 1497685373;
    WeChat = 836500024;
    WhatsApp = 310633997;

    # Media
    Infuse = 1136220934;
    VidHub = 1659622164;

    # Input
    CobraTyping = 6784869356;
    "Squirrel Designer" = 1530616498;
  };
}
