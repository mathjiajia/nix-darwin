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
    # jujutsu
    keka
    # lazyjj
    ollama
    loopwm
    # mathpix-snipping-tool
    # microsoft-edge
    raycast
    skimpdf
    # sublime-merge
    # warp-terminal
    # zed-editor
    zoom-us
    # zotero
  ];

  environment.shells = [pkgs.fish];

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
