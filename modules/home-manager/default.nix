{ inputs, pkgs, ... }: {
  home = {
    stateVersion = "26.11";
    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      MANPAGER = "nvim +Man!";
    };
    shellAliases.nv = "nvim";

    packages = with pkgs; [
      # CLI
      # container # Apple
      elan # lean
      hugo
      luajit
      mermaid-cli
      numr
      python3
      texlab # use in skim
      typst

      # Fonts
      lxgw-wenkai
      # maple-mono.NF-CN
      # sarasa-gothic
      # smiley-sans
      # nerd-fonts.iosevka-term
      nerd-fonts.symbols-only
    ];
  };

  programs = {
    home-manager.enable = true; # manage itslef

    atuin.enable = true;
    btop.enable = true;
    bun.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    npm.enable = true;
    pandoc.enable = true;
    uv.enable = true;

    # antigravity-cli.enable = true;
    # claude-code.enable = true;
    # codex.enable = true;

    bat = {
      enable = true;
      config = {
        italic-text = "always";
        tabs = "2";
        theme-light = "Catppuccin Latte";
        theme-dark = "Catppuccin Mocha";
      };
    };

    fish = {
      enable = true;
      interactiveShellInit = # fish
        ''
          set fish_greeting
          fish_config theme choose catppuccin-mocha --color-theme=dark
        '';
      shellAbbrs.mkdir = "mkdir -p";
    };

    nh = {
      enable = true;
      flake = "/etc/nix-darwin";
    };

    nixvim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      # Reuse Home Manager's package set instead of evaluating Nixpkgs again.
      nixpkgs.useGlobalPackages = true;
      defaultEditor = true;
      imports = [ ./nvim ];
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

    # ./tui/btop.nix
    ./tui/fd.nix
    ./tui/fzf.nix
    ./tui/herdr.nix
    ./tui/ripgrep.nix

    ./gui/ghostty.nix
    ./gui/kitty.nix
    ./gui/neovide.nix
    # ./gui/omniwm.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
  ];
}
