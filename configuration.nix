{ inputs, pkgs, hostName, ... }:
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
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
    # overlays = [ ];
  };

  system = {
    primaryUser = user;
    stateVersion = 6;
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  };

  # darwin-rebuild and nh pick the configuration with this name.
  networking.localHostName = hostName;

  # run `chsh -s /run`
  environment.shells = [ pkgs.fish ];
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  nix-homebrew = {
    enable = true;
    user = user;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs hostName; };
    users.${user}.imports = [ ./modules/home-manager ];
  };
}
