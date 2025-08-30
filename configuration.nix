{inputs, ...}: let
  user = "jia";
  system = "aarch64-darwin";
in {
  nix = {
    enable = true;
    settings.experimental-features = "nix-command flakes";
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
      "nikitabobko/homebrew-tap" = inputs.aerospace;
      "fcitx-contrib/homebrew-tap" = inputs.fcitx;
      "lihaoyun6/homebrew-tap" = inputs.lihaoyun6;
    };
    mutableTaps = false;
    extraEnv.HOMEBREW_NO_ANALYTICS = "1";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.${user}.imports = [
      inputs.nixvim.homeModules.nixvim
      ./modules/home-manager
    ];
  };
}
