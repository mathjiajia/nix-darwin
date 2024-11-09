{pkgs, ...}: {
  imports = [
    ./settings/homebrew.nix
    ./settings/mas.nix
    # ./settings/system.nix

    # ./services/aerospace.nix
    ./services/jankyborders.nix
  ];

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
    keka
    ollama
    loopwm
    # mathpix-snipping-tool
    # microsoft-edge
    raycast
    skimpdf
    # sublime-merge
    # warp-terminal
    zed-editor
    zoom-us
    # zotero
  ];

  environment.shells = with pkgs; [fish];

  fonts.packages = with pkgs; [
    # maple-mono-NF
    lxgw-wenkai
    sarasa-gothic
    smiley-sans
    (pkgs.nerdfonts.override {
      fonts = ["IosevkaTerm" "NerdFontsSymbolsOnly"];
    })
  ];
}
