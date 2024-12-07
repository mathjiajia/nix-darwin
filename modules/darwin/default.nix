{pkgs, ...}: {
  imports = [
    ./settings/homebrew.nix
    ./settings/mas.nix
    # ./settings/system.nix

    # ./services/aerospace.nix # not finish
    # ./services/jankyborders.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI
    # cachix
    difftastic
    hugo
    onefetch
    superfile
    # swift-format # old
    tree
    unrar

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
    aerospace
    # follow # x86_64-linux
    # github-desktop # linux
    # ghostty # closed beta
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
    zed-editor
    zoom-us
    # zotero # x86_64-linux
  ];

  environment.shells = with pkgs; [fish];

  fonts.packages = with pkgs; [
    # maple-mono-NF
    lxgw-wenkai
    sarasa-gothic
    smiley-sans
    # nerd-fonts.departure-mono
    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
  ];
}
