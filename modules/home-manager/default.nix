{ pkgs, ... }: {
  imports = [
    ./shell.nix

    ./programs/fzf.nix
    ./programs/git
    ./programs/neovide.nix
    ./programs/nixvim.nix
    ./programs/rex.nix
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
      nodejs
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
    gh.enable = true;
    home-manager.enable = true; # manage itslef
    man.enable = false; # see above
    # pandoc.enable = true;
    uv.enable = true;

    opencode = {
      enable = true;
      # Temporary fix for the 2.2.5 dependency hash on Apple Silicon.
      # Stop overriding once nixpkgs changes the version or expected hash.
      package =
        if
          pkgs.stdenv.hostPlatform.isDarwin
          && pkgs.stdenv.hostPlatform.isAarch64
          && pkgs.opencode.version == "2.2.5"
          && pkgs.opencode.node_modules.outputHash == "sha256-xfOVcw1+waLVNhFDwzOtzxrUSQEogvn88YomydOlhwc="
        then
          pkgs.opencode.overrideAttrs (oldAttrs: {
            node_modules = oldAttrs.node_modules.overrideAttrs {
              outputHash = "sha256-dIveiaiPFGSItwLyeMuPDxTE9gpvvnlTCB/+nG24qCc=";
            };
          })
        else
          pkgs.opencode;
    };
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
