{
  description = "Jia's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-bundle.flake = false;

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    homebrew-bundle,
    nixvim,
    neovim-nightly-overlay,
    ...
  } @ inputs: let
    system = "aarch64-darwin";
    username = "jia";

    commonModules = [
      ./configuration.nix
      ./modules/darwin
      home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit (inputs) nixpkgs neovim-nightly-overlay;
          };
          users.${username}.imports = [
            nixvim.homeManagerModules.nixvim
            ./modules/home-manager
          ];
        };
      }

      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = "${username}";
          taps = {
            "homebrew/homebrew-bundle" = homebrew-bundle;
          };
          mutableTaps = false;
        };
      }
    ];
  in {
    # macOS configurations.
    darwinConfigurations = {
      "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules =
          commonModules
          ++ [./modules/darwin/extra.nix];
      };

      "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = commonModules;
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Jias-MacBook-Pro".pkgs;
  };
}
