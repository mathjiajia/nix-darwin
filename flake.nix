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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      homebrew-bundle,
      neovim-nightly-overlay,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      nixvim,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";

      commonModules = [
        # Nix Modules.
        ./configuration.nix
        ./darwin.nix

        # System configuration.
        # ./system/settings.nix

        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jia = {
            imports = [
              ./modules
              nixvim.homeManagerModules.nixvim
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
    in
    {
      # macOS configurations.
      darwinConfigurations = {
        "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = commonModules ++ [
            ./extra.nix
          ];
        };

        "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
          inherit system;
          modules = commonModules;
        };
      };
    };
}
