{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # corretto11 # Matlab Apple Sillicon
    discord
  ];

  imports = [
    ./homebrew/homebrew-extra.nix
    ./mas/mas-extra.nix
  ];
}
