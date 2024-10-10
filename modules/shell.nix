{ ... }:
{
  imports = [
    ./bat
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ripgrep.nix
    ./starship.nix
    ./yazi.nix
  ];

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
