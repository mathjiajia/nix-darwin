{ pkgs, ... }:
{
  environment.pathsToLink = [ "/share/zsh" ];

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
