{ pkgs, ... }:
{
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    # CLI
    container
    crush
    elan # lean
    hugo
    luajit
    # numr

    # PYTHON
    (python3.withPackages (ps: [ ps.jupyterlab ]))
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
    # ./mas/mas.nix
    ./system.nix
  ];
}
