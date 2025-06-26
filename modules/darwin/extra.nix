{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # discord
    # flashspace
    gemini-cli
    # lmstudio
    # warp-terminal
  ];

  imports = [
    ./homebrew/homebrew-extra.nix
    ./mas/mas-extra.nix
  ];
}
