{pkgs, ...}: {
  imports = [
    ./homebrew/homebrew.nix
    ./mas/mas.nix
    ./system.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI
    ghostscript
    hugo
    tree
    wget
    bun
    nodejs
    uv

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

    # TeX
    texliveFull

    # GUI
    aerospace
    # chatgpt
    # cherry-studio # linux
    emacs
    # ghostty
    # github-desktop # linux
    ice-bar
    iina
    istatmenus
    inkscape
    keka
    kitty
    loopwm
    # mathematica # x86_64-linux
    # mathpix-snipping-tool # x86_64-linux
    # microsoft-edge # x86_64-linux
    neovide
    ollama
    openconnect
    # openra # x86_64-linux
    raycast
    sioyek
    skimpdf
    # stats
    # vscode
    zed-editor
    zoom-us
    zotero
  ];

  environment.shells = [pkgs.fish];

  fonts.packages = with pkgs; [
    lxgw-wenkai
    maple-mono.NF-CN
    sarasa-gothic
    smiley-sans

    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
  ];
}
