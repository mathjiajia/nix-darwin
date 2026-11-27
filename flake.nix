{
  description = "Personal Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    rex.url = "https://pkgs.superlogical.com/rex/nix/snapshot.tar.gz";
    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # Neovim (nixvim)
    nixvim.url = "github:nix-community/nixvim";
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
    {
      darwinConfigurations = inputs.nixpkgs.lib.genAttrs [ "macbook-pro-m3" "macbook-pro-m6" "mac-mini" ] (
        hostName:
        nix-darwin.lib.darwinSystem {
          modules = [
            ./configuration.nix
            ./modules/darwin
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            ./hosts/${hostName}.nix
          ];
          specialArgs = { inherit inputs hostName; };
        }
      );
    };
}
