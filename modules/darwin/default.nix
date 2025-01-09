{pkgs, ...}: {
  imports = [
    ./homebrew/homebrew.nix
    ./mas/mas.nix
    # ./system.nix

    ./services/aerospace.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI
    hugo
    tree

    # PYTHON
    (python3.withPackages (ps:
      with ps; [
        jupyter
        matplotlib
        numpy
        pandas
        plotly
        scipy
      ]))

    # GUI
    # follow # x86_64-linux
    # github-desktop # linux
    ice-bar
    iina
    inkscape
    keka
    # loopwm # with aerospace
    # mathematica # x86_64-linux
    # mathpix-snipping-tool # x86_64-linux
    # microsoft-edge # x86_64-linux
    ollama
    # openra # x86_64-linux
    raycast
    skimpdf
    # stats
    # sublime-merge # linux
    zoom-us
    zotero
  ];

  environment.shells = [pkgs.fish];

  fonts.packages = with pkgs; [
    lxgw-wenkai
    # maple-mono
    sarasa-gothic
    smiley-sans

    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
  ];
}
