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
    # Neovim (nixvim)
    nixvim.url = "github:nix-community/nixvim";
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
        "MBP" = config;
        "MBO" = config;
      };
    };
}
