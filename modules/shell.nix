{ ... }:
{
  imports = [
    ./bat
    ./fish.nix
    ./fzf.nix
    ./starship.nix
    ./yazi.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
