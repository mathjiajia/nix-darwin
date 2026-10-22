{ inputs, pkgs, ... }:
let
  user = "jia";
in
{
  nix = {
    enable = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ (import ./overlays/sioyek.nix) ];
  };

  system = {
    primaryUser = user;
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };

  users.users."${user}" = {
    home = "/Users/${user}";
    name = user;
    uid = 501;
  };

  # run `chsh -s /run/current-system/sw/bin/fish`
  environment.shells = [ pkgs.fish ];
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  nix-homebrew = {
    enable = true;
    user = user;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users.${user}.imports = [
      ./modules/home-manager
    ];
  };
}
