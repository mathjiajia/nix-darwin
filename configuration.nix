{ inputs, ... }:
let
  user = "jia";
  system = "aarch64-darwin";
in
{
  nix = {
    enable = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
    hostPlatform = system;
    config.allowUnfree = true;
  };

  system = {
    primaryUser = user;
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };

  users.users."${user}" = {
    name = user;
    home = "/Users/${user}";
  };

  nix-homebrew = {
    enable = true;
    user = user;
    taps = {
      "acsandmann/homebrew-tap" = inputs.rift;
      "fcitx-contrib/homebrew-tap" = inputs.fcitx;
      "lihaoyun6/homebrew-tap" = inputs.quickrecorder;
    };
    mutableTaps = false;
    extraEnv.HOMEBREW_NO_ANALYTICS = "1";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users.${user}.imports = [
      inputs.nixvim.homeModules.nixvim
      ./modules/home-manager
    ];
  };
}
