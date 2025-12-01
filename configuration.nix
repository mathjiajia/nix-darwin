{ inputs, pkgs, ... }:
let
  user = "jia";
  system = "aarch64-darwin";
in
{
  nix.enable = false;

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
    home = "/Users/${user}";
    name = user;
    shell = pkgs.fish;
    uid = 501;
  };

  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;

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
    extraSpecialArgs = { inherit inputs; };
    users.${user}.imports = [
      ./modules/home-manager
      inputs.nixvim.homeModules.nixvim
    ];
  };
}
