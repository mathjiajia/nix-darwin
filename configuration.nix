{
  inputs,
  pkgs,
  ...
}: {
  nix.enable = true;

  nixpkgs.config.allowUnfree = true;

  users.users."jia" = {
    name = "jia";
    home = "/Users/jia";
    shell = pkgs.fish;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "jia";
    taps = {
      "fcitx-contrib/homebrew-tap" = inputs.fcitx;
      "nikitabobko/homebrew-tap" = inputs.aerospace;
    };
    mutableTaps = false;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users."jia".imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./modules/home-manager
    ];
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
