{pkgs, ...}: {
  imports = [
    ./homebrew/homebrew.nix
    ./mas/mas.nix
    ./system.nix
  ];

  environment.pathsToLink = ["/share/zsh"];

  environment.systemPackages = with pkgs; [
    # CLI
    # cargo
    hugo
    luajit
    nodejs # npx

    # PYTHON
    (python3.withPackages (ps:
      with ps; [
        jupyter
        matplotlib
        numpy
        pandas
        plotly
        pylatexenc
        scipy
        tqdm
      ]))
  ];

  environment.shells = [pkgs.nushell];

  fonts.packages = with pkgs; [
    lxgw-wenkai
    maple-mono.NF-CN
    sarasa-gothic
    smiley-sans

    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
  ];
}
