{
  # environment.systemPackages = with pkgs; [
    # corretto11 # Matlab Apple Sillicon
    # discord
    # flashspace
    # lmstudio # broken
    # warp-terminal
  # ];

  imports = [
    ./homebrew/homebrew-extra.nix
    ./mas/mas-extra.nix
  ];
}
