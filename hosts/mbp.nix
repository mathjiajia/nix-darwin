{
  # Settings specific to mbp.
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew.casks = [
    # AI
    "antigravity"
    "antigravity-cli"

    # System and hardware
    "8bitdo-firmware-updater"
    "display-pilot"
    "hhkb"
    "sf-symbols"

    # Productivity
    "hazeover"
    "raycast"

    # Media and design
    "downie"
    "iina"
    "inkscape"
    "permute"

    # Browsers and communication
    "google-chrome"
    "qq"
    "zoom"

    # Input
    "squirrel-app"

    # Games
    "openra"
  ];

  programs.mas.packages = {
    "Apple Configurator" = 1037126344;
    "Swift Playground" = 1496833156;
    TestFlight = 899247664;
  };
}
