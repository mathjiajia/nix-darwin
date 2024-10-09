{ ... }:
{
  imports = [
    ./bat
    ./fish
    ./fzf.nix
    ./starship.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
