{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    discord
    # dotnet-sdk_6
  ];

  imports = [
    ./homebrew/homebrew-extra.nix
    ./mas/mas-extra.nix
  ];
}
