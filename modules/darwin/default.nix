{pkgs, ...}: {
  imports = [
    ./settings/homebrew.nix
    ./settings/mas.nix
    # ./settings/system.nix

    ./services/aerospace.nix # not finish
    # ./services/jankyborders.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI
    difftastic
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
    # ghostty
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
    # sioyek
    skimpdf
    # sublime-merge # linux
    zed-editor
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
