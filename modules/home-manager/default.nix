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

  xdg.enable = true;

  home = {
    stateVersion = "26.11";

    # see https://github.com/nix-community/home-manager/pull/8723
    extraOutputsToInstall = [ "man" ];

    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      MANPAGER = "nvim +Man!";
    };

    packages = with pkgs; [
      # AI
      omp

      # CLI
      # container # Apple
      elan # lean
      hugo
      luajit
      # mermaid-cli
      python3
      # typst

      # Fonts
      (google-fonts.override {
        fonts = [ "Mozilla Text" ];
      })
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

    opencode.enable = true;
    pi-coding-agent.enable = true;

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
}
