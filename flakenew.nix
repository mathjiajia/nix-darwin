{
  description = "Jia's Darwin system flake";

  nixConfig =
    {
    };

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

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      home-manager,
      homebrew-bundle,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      # nixvim,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."jia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          home-manager.darwinModules.home-manager
          # nixvim.homeManagerModules.nixvim
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

          {
            home = {
              username = "jia";
              homeDirectory = "/Users/jia";
              stateVersion = "24.11";
            };
          }
        ];
      };
      darwinConfigurations =
        let
          commonModules = [
            {
              nixpkgs.overlays = [
                inputs.neovim-nightly-overlay.overlays.default
              ];
            }

            ./configuration.nix
            # ./system/settings.nix
            ./modules/home.nix
            ./modules/pkgs.nix
          ];
          specialArgs = {
            inherit inputs;
          };
        in
        {
          Jias-MacBook-Pro = nix-darwin.lib.darwinSystem {
            inherit system;
            modules = commonModules ++ [
              ./extra.nix
            ];
            specialArgs = specialArgs;
          };
          Jias-MacBook-Pro-M1 = nix-darwin.lib.darwinSystem {
            inherit system;
            modules = commonModules;
            specialArgs = specialArgs;
          };
        };
    };
}
