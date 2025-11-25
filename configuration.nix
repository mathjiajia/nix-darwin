{ inputs, ... }:
let
  user = "jia";
  system = "aarch64-darwin";
in
{
  nix = {
    enable = false;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
      "fcitx-contrib/homebrew-tap" = inputs.fcitx;
      "tw93/homebrew-tap" = inputs.mole;
      "lihaoyun6/homebrew-tap" = inputs.quickrecorder;
      "acsandmann/homebrew-tap" = inputs.rift;
    };
    mutableTaps = false;
    extraEnv.HOMEBREW_NO_ANALYTICS = "1";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${user}.imports = [
      inputs.nixvim.homeModules.nixvim
      ./modules/home-manager
    ];
  };
}
