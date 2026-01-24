{
  description = "Personal Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # homebrew-taps
    omniwm.url = "github:BarutSRB/homebrew-tap";
    omniwm.flake = false;
    quickrecorder.url = "github:lihaoyun6/homebrew-tap";
    quickrecorder.flake = false;
    # Neovim (nixvim)
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{
      nix-darwin,
      nix-homebrew,
      home-manager,
      ...
    }:
    let
      config = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          ./modules/darwin
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
        specialArgs = { inherit inputs; };
      };
    in
    {
      darwinConfigurations = {
        "Jias-MacBook-Pro" = config;
        "Jias-MacBook-Pro-M1" = config;
      };
    };
}
