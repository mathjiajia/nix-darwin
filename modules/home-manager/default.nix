{
  inputs,
  pkgs,
  ...
}:
let
  pkgsSmall = inputs.nixpkgs-small.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim

    ./shell.nix

    ./programs/fzf.nix
    ./programs/git
    ./programs/rex
    ./programs/yazi

    # ./programs/omniwm
    # ./programs/sioyek.nix
  ];

  xdg.enable = true;

  home = {
    stateVersion = "26.11";
    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      MANPAGER = "nvim +Man!";
    };

    # see https://github.com/nix-community/home-manager/pull/8723
    extraOutputsToInstall = [ "man" ];

    packages = with pkgs; [
      # AI
      pkgsSmall.omp

      # CLI
      # container # Apple
      elan # lean
      hugo
      luajit
      # mermaid-cli
      nodejs
      python3
      # typst

      # Fonts
      lxgw-wenkai
      # maple-mono.NF-CN
      nerd-fonts.symbols-only
    ];
  };

  programs = {
    home-manager.enable = true; # manage itslef

    btop.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    gh.enable = true;
    man.enable = false; # see above
    uv.enable = true;

    bat = {
      enable = true;
      config = {
        italic-text = "always";
        tabs = "2";
        theme = "auto:system";
        theme-light = "Catppuccin Latte";
        theme-dark = "Catppuccin Mocha";
      };
    };

    nh = {
      enable = true;
      flake = "/etc/nix-darwin";
    };

    nixvim = {
      enable = true;
      # Match plugin dependencies to the cached nightly Neovim package.
      nixpkgs.source = inputs.neovim-nightly-overlay.inputs.nixpkgs;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      defaultEditor = true;
      imports = [ ../nixvim ];
    };

    pi-coding-agent = {
      enable = true;
      package = pkgsSmall.pi-coding-agent;
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--glob=!.git"
        "--smart-case"
      ];
    };

    sagemath = {
      enable = true;
      package = null;
      initScript =
        # py
        ''
          %colors linux
          QUIET = var("alpha beta gamma delta epsilon zeta eta theta iota kappa mu nu xi omicron rho sigma tau upsilon phi chi psi omega");
        '';
    };

    tex-fmt = {
      enable = true;
      settings = {
        tabchar = "tab";
        tabsize = 1;
      };
    };
  };
}
