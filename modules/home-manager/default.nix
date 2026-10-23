{ pkgs, ... }: {
  imports = [
    ./shell.nix

    ./programs/fzf.nix
    # ./programs/ghostty.nix
    ./programs/git
    ./programs/kitty.nix
    ./programs/neovide.nix
    ./programs/nixvim.nix
    # ./programs/omniwm
    ./programs/sagemath.nix
    ./programs/sioyek.nix
    ./programs/yazi
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
      # container # Apple
      elan # lean
      hugo
      luajit
      mermaid-cli
      python3
      typst

      # Fonts
      lxgw-wenkai
      # maple-mono.NF-CN
      nerd-fonts.symbols-only
      # sarasa-gothic
    ];
  };

  programs = {
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

    btop.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    home-manager.enable = true; # manage itslef
    man.enable = false;

    nh = {
      enable = true;
      flake = "/etc/nix-darwin";
    };

    pandoc.enable = true;

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

    uv.enable = true;
  };

  # GUI applications are managed by Homebrew (except sioyek).
  targets.darwin.copyApps.enable = false;

  xdg.enable = true;
}
