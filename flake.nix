{
  description = "Personal Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # homebrew-taps
    fcitx = {
      url = "github:fcitx-contrib/homebrew-tap";
      flake = false;
    };
    quickrecorder = {
      url = "github:lihaoyun6/homebrew-tap";
      flake = false;
    };
    rift = {
      url = "github:acsandmann/homebrew-tap";
      flake = false;
    };
    mole = {
      url = "github:tw93/homebrew-tap";
      flake = false;
    };

    # Neovim (nixvim)
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      nix-homebrew,
      ...
    }@inputs:
    let
      special_args = { inherit inputs; };
      shared-modules = [
        ./configuration.nix
        ./modules/darwin
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
      ];
    in
    {
      darwinConfigurations = {
        "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          modules = shared-modules ++ [ ./modules/darwin/extra.nix ];
          specialArgs = special_args;
        };
        "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
          modules = shared-modules;
          specialArgs = special_args;
        };
      };
    };
}
