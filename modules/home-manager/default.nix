{
  home = {
    username = "jia";
    homeDirectory = "/Users/jia";
    stateVersion = "25.05";

    sessionVariables = {
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      DFT_PARSE_ERROR_LIMIT = 999;

      DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
      GEM_HOME = "$XDG_DATA_HOME/gem";
      GEM_SPEC_CACHE = "$XDG_CACHE_HOME/gem";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
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
