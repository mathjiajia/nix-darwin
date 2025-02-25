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

    yazi-plugins.url = "github:yazi-rs/plugins";
    yazi-plugins.flake = false;

    mysnippets.url = "github:mathjiajia/mySnippets";
    mysnippets.flake = false;
    nvim-latex.url = "github:mathjiajia/latex.nvim";
    nvim-latex.flake = false;
    nvim-treesitter-pairs.url = "github:lewis6991/nvim-treesitter-pairs";
    nvim-treesitter-pairs.flake = false;
    # nvzone-showkeys.url = "github:nvzone/showkeys";
    # nvzone-showkeys.flake = false;
    # nvzone-timerly.url = "github:nvzone/timerly";
    # nvzone-timerly.flake = false;
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    nixvim,
    ...
  }: let
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
          backupFileExtension = "backup";
          extraSpecialArgs = {inherit inputs;};
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
          taps = {"homebrew/homebrew-bundle" = inputs.homebrew-bundle;};
          mutableTaps = false;
        };
      }
    ];
  in {
    darwinConfigurations = {
      "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = commonModules ++ [./modules/darwin/extra.nix];
      };

      "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = commonModules;
      };
    };
  };
}
