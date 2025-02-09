{config, ...}: {
  home = {
    username = "jia";
    homeDirectory = "/Users/jia";
    stateVersion = "25.05";

    sessionVariables = {
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";

      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      GEM_HOME = "${config.xdg.dataHome}/gem";
      GEM_SPEC_CACHE = "${config.xdg.cacheHome}/gem";
      IPYTHONDIR = "${config.xdg.configHome}/ipython";
      JUPYTER_CONFIG_DIR = "${config.xdg.configHome}/jupyter";
      MPLCONFIGDIR = "${config.xdg.configHome}/matplotlib";
    };
  };

  programs = {
    home-manager.enable = true; # manage itslef
    pandoc.enable = true;
    zoxide.enable = true;
  };

  imports = [
    ./tui/git
    ./tui/nvim
    ./tui/yazi

    ./tui/bat.nix
    ./tui/btop.nix
    ./tui/fastfetch.nix
    ./tui/fd.nix
    ./tui/fish.nix
    ./tui/fzf.nix
    ./tui/ripgrep.nix
    ./tui/starship.nix
    # ./tui/tex-fmt.nix
    ./tui/texlive.nix

    ./gui/aerospace.nix
    ./gui/emacs.nix
    ./gui/kitty.nix
    ./gui/ghostty.nix
    ./gui/neovide.nix
    ./gui/sioyek.nix
    ./gui/vscode.nix
    ./gui/zed.nix
  ];

  xdg.enable = true;
}
