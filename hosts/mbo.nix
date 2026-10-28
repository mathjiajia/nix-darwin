{
  # Settings specific to mbo.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow the SSH build account to import build inputs into the Nix store.
  nix.settings.trusted-users = [ "jia" ];
}
