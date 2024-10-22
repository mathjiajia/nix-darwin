{ pkgs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  environment.systemPackages = with pkgs; [
    aerospace
    # follow
    # github-desktop
    # ghostty
    ice-bar
    iina
    inkscape-with-extensions
    # jujutsu
    keka
    # lazyjj
    # marktext
    ollama
    loopwm
    # mathpix-snipping-tool
    # microsoft-edge
    skimpdf
    # sublime-merge
    raycast
    # warp-terminal
    # zed-editor
    zoom-us
    # zotero
  ];

  fonts.packages = with pkgs; [
    # maple-mono-NF
    lxgw-wenkai
    smiley-sans
    (pkgs.nerdfonts.override {
      fonts = [
        "IosevkaTerm"
        "ProggyClean"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];

}
