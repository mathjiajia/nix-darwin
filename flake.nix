{
  description = "Jia's Darwin system flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # homebrew-tap
    aerospace.url = "github:nikitabobko/homebrew-tap";
    aerospace.flake = false;
    fcitx.url = "github:fcitx-contrib/homebrew-tap";
    fcitx.flake = false;
    lihaoyun6.url = "github:lihaoyun6/homebrew-tap"; # quickrecorder
    lihaoyun6.flake = false;

    # Neovim (nixvim)
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Additional Neovim plugins
    fff-nvim.url = "github:dmtrKovalenko/fff.nvim";
    fff-nvim.inputs.nixpkgs.follows = "nixpkgs";

    blink-indent.url = "github:saghen/blink.indent";
    blink-indent.flake = false;
    # math-conceal-nvim.url = "github:pxwg/math-conceal.nvim";
    # math-conceal-nvim.flake = false;
    nvim-latex-conceal.url = "github:mathjiajia/nvim-latex-conceal";
    nvim-latex-conceal.flake = false;
    nvim-math-snippets.url = "github:mathjiajia/nvim-math-snippets";
    nvim-math-snippets.flake = false;
    slimline-nvim.url = "github:sschleemilch/slimline.nvim";
    slimline-nvim.flake = false;
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
      nix-homebrew.darwinModules.nix-homebrew
      home-manager.darwinModules.home-manager
    ];
  in {
    darwinConfigurations = {
      "Jias-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = shared-modules ++ [./modules/darwin/extra.nix];
        specialArgs = special_args;
      };

      "Jias-MacBook-Pro-M1" = nix-darwin.lib.darwinSystem {
        modules = shared-modules;
        specialArgs = special_args;
      };
    };
  };
}
