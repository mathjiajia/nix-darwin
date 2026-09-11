{
  description = "Personal Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/pull/9900/merge";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Neovim (nixvim)
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    # Keep nightly's own package set so its upstream binary cache stays usable.
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
        "mbp" = config;
        "mbo" = config;
      };
    };
}
