{ pkgs, ... }:
{
  imports = [
    # ./settings/system.nix
    ./settings/homebrew.nix
    ./settings/homebrew-extra.nix
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
    jankyborders
    # jujutsu
    keka
    # lazyjj
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

  environment.shells = [ pkgs.fish ];

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
