{
  # environment.systemPackages = with pkgs; [
  #   discord
  #   flashspace
  #   lmstudio
  #   warp-terminal
  # ];

  imports = [
    ./homebrew/homebrew-extra.nix
    ./mas/mas-extra.nix
  ];
}
