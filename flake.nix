{
  description = "Jia's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-bundle,
      neovim-nightly-overlay,
      ...
    }@inputs:
    {
      # macOS configurations.
      darwinConfigurations."Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          # Nix Modules.
          ./configuration.nix
          # System configuration.
          # ./system/settings.nix
          # Home Manager configuration.
          home-manager.darwinModules.home-manager
          {
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jia = {
              imports = [
                ./modules/home.nix
                ./modules/pkgs.nix
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit (inputs) nixpkgs neovim-nightly-overlay;
            };
          }

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "jia";
              taps = {
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Jias-MacBook-Pro".pkgs;
    };
}
