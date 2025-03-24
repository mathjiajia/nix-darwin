{
  description = "Jia's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.url = "github:dwt/nix-darwin/application-linking-done-right";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # homebrew
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # fcitx5 macOS
    fcitx.url = "github:fcitx-contrib/homebrew-tap";
    fcitx.flake = false;

    # Neovim (nixvim)
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Additional Neovim plugins
    nvim-math-snippets.url = "github:mathjiajia/nvim-math-snippets";
    nvim-math-snippets.flake = false;
    nvim-latex-conceal.url = "github:mathjiajia/nvim-latex-conceal";
    nvim-latex-conceal.flake = false;
    nvim-treesitter-pairs.url = "github:lewis6991/nvim-treesitter-pairs";
    nvim-treesitter-pairs.flake = false;
    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";
    mcphub-nvim.flake = false;

    # Yazi file manager plugins
    yazi-plugins.url = "github:yazi-rs/plugins";
    yazi-plugins.flake = false;
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
          taps = {"fcitx-contrib/homebrew-tap" = inputs.fcitx;};
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
