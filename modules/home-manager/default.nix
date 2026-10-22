{ pkgs, ... }: {
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

  xdg.enable = true;

  # see https://github.com/nix-community/home-manager/pull/8723
  home.extraOutputsToInstall = [ "man" ];
  programs.man.enable = false;

  imports = [
    ./shell.nix

    ./programs/nixvim.nix
    ./programs/git
    ./programs/yazi

    ./programs/fzf.nix
    ./programs/herdr.nix

    ./programs/ghostty.nix
    ./programs/kitty.nix
    ./programs/neovide.nix
    # ./programs/omniwm
    ./programs/sagemath.nix
    ./programs/sioyek.nix
  ];
}
