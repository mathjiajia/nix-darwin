{ pkgs, ... }:
{
  environment.pathsToLink = [ "/share/zsh" ];

  environment.systemPackages = with pkgs; [
    # CLI
    cargo
    crush
    elan # lean
    hugo
    # go
    luajit
    # nodejs # npx
    scooter

    # PYTHON
    (python3.withPackages (
      ps: with ps; [
        jupyter
        matplotlib
        numpy
        pandas
        # plotly
        pylatexenc
        scipy
        tqdm
      ]
    ))
  ];

  fonts.packages = with pkgs; [
    lxgw-wenkai
    maple-mono.NF-CN
    sarasa-gothic
    smiley-sans

    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
  ];

  imports = [
    ./homebrew/homebrew.nix
    ./mas/mas.nix
    ./system.nix
  ];
}
