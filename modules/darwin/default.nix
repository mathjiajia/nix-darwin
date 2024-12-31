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
    swift-format
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
    ghostty
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
    # sublime-merge # linux
    zoom-us
    zotero
  ];

  environment.shells = with pkgs; [fish];

  fonts.packages = with pkgs; [
    lxgw-wenkai
    # maple-mono
    sarasa-gothic
    smiley-sans

    nerd-fonts.symbols-only
  ];
}
