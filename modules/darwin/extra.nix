{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # corretto11 # Matlab Apple Sillicon
    discord
    # dotnet-sdk
  ];

  imports = [
    ./homebrew/homebrew-extra.nix
    ./mas/mas-extra.nix
  ];
}
