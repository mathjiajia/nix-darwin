{ pkgs, ... }:
{
  # Settings specific to mbp.
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    distributedBuilds = true;
    settings.builders-use-substitutes = true;
    buildMachines = [
      {
        hostName = "100.98.183.21"; # mbo on Tailscale.
        system = "aarch64-darwin";
        protocol = "ssh-ng";
        sshUser = "jia";
        # Provision separately and authorise the public key on mbo.
        sshKey = "/var/root/.ssh/mbo-builder";
        # Pin mbo's public SSH host key, verified through its Rex connection.
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU04LzlzYWNseDBUT04vZnAzU2lxYXdybndVT2F5TVBDdTg5RE9Va3RUeTEK";
      }
    ];
  };

  home-manager.users.jia = {
    home.packages = with pkgs; [
      omp
      opencode
    ];
    programs.pi-coding-agent.enable = true;
    # programs.omp = {
    #   enable = true;
    #   settings.startup.quiet = true;
    # };

  };

  homebrew.casks = [
    # AI
    "antigravity"
    "antigravity-cli"
    "deepseek-harness"
    "lobehub"

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
    "discord"
    "google-chrome"
    "qq"
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

    # Media
    Infuse = 1136220934;
    VidHub = 1659622164;

    # Input
    CobraTyping = 6784869356;
    "Squirrel Designer" = 1530616498;
  };
}
