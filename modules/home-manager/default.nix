{ pkgs, ... }: {
  imports = [
    ./shell.nix

    ./programs/fzf.nix
    ./programs/git
    ./programs/neovide.nix
    ./programs/nixvim.nix
    ./programs/sagemath.nix
    ./programs/yazi

    # ./programs/omniwm
    # ./programs/sioyek.nix
  ];

  home = {
    stateVersion = "26.11";

    # see https://github.com/nix-community/home-manager/pull/8723
    extraOutputsToInstall = [ "man" ];

    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      MANPAGER = "nvim +Man!";
    };

    packages = with pkgs; [
      # CLI
      cachix
      # container # Apple
      elan # lean
      hugo
      luajit
      # mermaid-cli
      python3
      # typst

      # Fonts
      lxgw-wenkai
      # maple-mono.NF-CN
      nerd-fonts.symbols-only
      # sarasa-gothic
    ];
  };

  programs = {
    btop.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    home-manager.enable = true; # manage itslef
    man.enable = false; # see above
    # pandoc.enable = true;
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

    ripgrep = {
      enable = true;
      arguments = [
        "--hidden"
        "--glob=!.git"
        "--smart-case"
      ];
    };

    tex-fmt = {
      enable = true;
      settings = {
        tabchar = "tab";
        tabsize = 1;
      };
    };
  };

  # GUI applications are managed by Homebrew.
  targets.darwin.copyApps.enable = false;

  xdg.enable = true;
}
