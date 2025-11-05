{
  description = "Personal Darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # homebrew
    nix-homebrew.url = "github:rick-yao/nix-homebrew";

    # homebrew-taps
    rift = {
      url = "github:acsandmann/homebrew-tap";
      flake = false;
    };
    fcitx = {
      url = "github:fcitx-contrib/homebrew-tap";
      flake = false;
    };
    quickrecorder = {
      url = "github:lihaoyun6/homebrew-tap";
      flake = false;
    };

    # Neovim (nixvim)
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # lean-nvim = {
    #   url = "github:Julian/lean.nvim";
    #   flake = false;
    # };
    # math-conceal-nvim = {
    #   url = "github:pxwg/math-conceal.nvim";
    #   flake = false;
    # };
    nvim-latex-conceal = {
      url = "github:mathjiajia/nvim-latex-conceal";
      flake = false;
    };
    nvim-math-snippets = {
      url = "github:mathjiajia/nvim-math-snippets";
      flake = false;
    };
  };

  outputs =
    {
      nix-darwin,
      home-manager,
      nix-homebrew,
      ...
    }@inputs:
    let
      special_args = { inherit inputs; };

      shared-modules = [
        ./configuration.nix
        ./modules/darwin
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
      ];
    in
    {
      darwinConfigurations = {
        "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
          modules = shared-modules ++ [ ./modules/darwin/extra.nix ];
          specialArgs = special_args;
        };
        "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
          modules = shared-modules;
          specialArgs = special_args;
        };
      };
    };
}
