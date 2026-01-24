{ inputs, pkgs, ... }:
{
  home = {
    stateVersion = "26.05";
    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      GEMINI_API_KEY = "$(security find-generic-password -s 'GEMINI_API_KEY' -w)";
      MANPAGER = "nvim +Man!";
    };
    shellAliases.nv = "nvim";

    packages = with pkgs; [
      # CLI
      container # Apple
      crush
      elan # lean
      github-copilot-cli
      hugo
      luajit
      msedit
      numr
      typst

      # Fonts
      julia-mono
      lxgw-wenkai
      maple-mono.NF-CN
      sarasa-gothic
      smiley-sans
      nerd-fonts.iosevka-term
      nerd-fonts.symbols-only
    ];
  };

  programs = {
    home-manager.enable = true; # manage itslef

    atuin.enable = true;
    bun.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    npm.enable = true;
    pandoc.enable = true;
    uv.enable = true;

    claude-code.enable = true;
    codex.enable = true;
    gemini-cli.enable = true;
    opencode.enable = true;

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    nh = {
      enable = true;
      flake = "/etc/nix-darwin";
    };

    nixvim = {
      enable = true;
      defaultEditor = true;
      nixpkgs.config.allowUnfree = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      imports = [ ./nvim ];
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

  imports = [
    ./tui/git
    ./tui/yazi

    ./tui/bat.nix
    ./tui/fd.nix
    ./tui/fish.nix
    ./tui/fzf.nix
    ./tui/ripgrep.nix

    ./gui/ghostty.nix
    ./gui/neovide.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
  ];
}
