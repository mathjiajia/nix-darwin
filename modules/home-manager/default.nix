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
    ./cli/git
    ./cli/nvim
    ./cli/yazi

    ./cli/bat.nix
    ./cli/btop.nix
    ./cli/fastfetch.nix
    ./cli/fd.nix
    ./cli/fish.nix
    ./cli/fzf.nix
    ./cli/ripgrep.nix
    ./cli/starship.nix
    # ./cli/tex-fmt.nix
    ./cli/texlive.nix

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
