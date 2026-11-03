{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pkgsSmall = inputs.nixpkgs-small.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
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

    pi-coding-agent = {
      enable = true;
      package = pkgsSmall.pi-coding-agent;
    };

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
