{ ... }:
{
  imports = [
    ./bat
    ./btop.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ripgrep.nix
    ./starship.nix
    ./yazi.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
