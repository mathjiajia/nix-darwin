{ pkgs, ... }:
{
  imports = [
    # ./settings/system.nix
    ./settings/homebrew.nix
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
