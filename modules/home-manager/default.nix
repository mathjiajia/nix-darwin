{ inputs, pkgs, ... }: {
  # GUI applications are managed by Homebrew (except sioyek).
  targets.darwin.copyApps.enable = false;

  home = {
    stateVersion = "26.11";
    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      MANPAGER = "nvim +Man!";
    };

    packages = with pkgs; [
      # CLI
      # container # Apple
      elan # lean
      hugo
      luajit
      mermaid-cli
      python3
      texlab # use in skim
      typst

      # Fonts
      lxgw-wenkai
      # maple-mono.NF-CN
      # sarasa-gothic
      nerd-fonts.symbols-only
    ];
  };

  programs = {
    home-manager.enable = true; # manage itslef

    atuin.enable = true;
    btop.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    pandoc.enable = true;
    uv.enable = true;

    bat = {
      enable = true;
      config = {
        italic-text = "always";
        tabs = "2";
        # theme = "auto:system";
        # theme-light = "Catppuccin Latte";
        theme = "Catppuccin Mocha";
      };
    };

    fish = {
      enable = true;
      interactiveShellInit = # fish
        ''
          set fish_greeting
          fish_config theme choose catppuccin-mocha --color-theme=dark
        '';
      shellAbbrs = {
        mkdir = "mkdir -p";
        nv = "nvim";
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
      # Reuse the system viewer, including its package overrides.
      nixpkgs.overlays = [ (_final: _prev: { inherit (pkgs) sioyek; }) ];
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      defaultEditor = true;
      imports = [ ./nvim ];
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--glob=!.git"
        "--smart-case"
      ];
    };

    starship = {
      enable = true;
      settings.add_newline = false;
    };

    tex-fmt = {
      enable = true;
      settings = {
        tabchar = "tab";
        tabsize = 1;
      };
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
  };

  xdg.enable = true;

  # see https://github.com/nix-community/home-manager/pull/8723
  home.extraOutputsToInstall = [ "man" ];
  programs.man.enable = false;

  imports = [
    ./tui/git
    ./tui/yazi

    ./tui/fzf.nix
    ./tui/herdr.nix

    ./gui/ghostty.nix
    ./gui/kitty.nix
    ./gui/neovide.nix
    # ./gui/omniwm.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
  ];
}
