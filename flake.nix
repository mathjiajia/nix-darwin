{
  description = "Jia's Darwin system flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # aerospace
    aerospace = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
    # fcitx5
    fcitx = {
      url = "github:fcitx-contrib/homebrew-tap";
      flake = false;
    };

    # Neovim (nixvim)
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Additional Neovim plugins
    nvim-math-snippets.url = "github:mathjiajia/nvim-math-snippets";
    nvim-math-snippets.flake = false;
    nvim-latex-conceal.url = "github:mathjiajia/nvim-latex-conceal";
    nvim-latex-conceal.flake = false;
    # latex_concealer-nvim.url = "github:mathjiajia/latex_concealer.nvim";
    # latex_concealer-nvim.flake = false;
    nvim-treesitter-pairs.url = "github:lewis6991/nvim-treesitter-pairs";
    nvim-treesitter-pairs.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    ...
  } @ inputs: let
    special_args = {inherit inputs;};

    shared-modules = [
      ./configuration.nix
      ./modules/darwin
      home-manager.darwinModules.home-manager
      nix-homebrew.darwinModules.nix-homebrew
    ];
  in {
    darwinConfigurations = {
      "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
        modules = shared-modules;
        specialArgs = special_args;
      };

      "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules =
          shared-modules ++ [./modules/darwin/extra.nix];
        specialArgs = special_args;
      };
    };
  };
}
