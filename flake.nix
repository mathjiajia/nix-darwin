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

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      nix-homebrew,
      # nixvim,
      nixpkgs,
      homebrew-bundle,
      neovim-nightly-overlay,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";

      commonModules = [
        # Nix Modules.
        ./configuration.nix

        # System configuration.
        # ./system/settings.nix

        # nixvim.homeManagerModules.nixvim
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
