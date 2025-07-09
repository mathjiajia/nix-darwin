{pkgs, ...}: {
  imports = [
    ./homebrew/homebrew.nix
    ./mas/mas.nix
    ./system.nix
  ];

  environment.systemPackages = with pkgs; [
    # CLI
    cargo
    hugo
    luajit
    nodejs # npx
    openconnect
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
        tqdm
      ]))
  ];

  environment = {
    shells = [pkgs.fish];
    variables = {
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
    };
    systemPath = ["/Library/TeX/texbin"];
  };

  fonts.packages = with pkgs; [
    lxgw-wenkai
    maple-mono.NF-CN
    sarasa-gothic
    smiley-sans

    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
  ];
}
