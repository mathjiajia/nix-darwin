{ pkgs, ... }:
{
  imports = [
    ./settings/bat
    ./settings/git
    ./settings/neovim
    ./settings/yazi

    ./settings/btop.nix
    ./settings/fastfetch.nix
    ./settings/fd.nix
    ./settings/fish.nix
    ./settings/fzf.nix
    ./settings/kitty.nix
    ./settings/neovide.nix
    ./settings/ripgrep.nix
    ./settings/sioyek.nix
    ./settings/starship.nix

    ./configs/aerospace.nix
    ./configs/ghostty.nix
  ];

  home = {
    username = "jia";
    homeDirectory = "/Users/jia";
    stateVersion = "24.11";

    sessionVariables = {
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      DFT_PARSE_ERROR_LIMIT = 999;
      HOMEBREW_NO_ANALYTICS = 1;

      DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
      GEM_HOME = "$XDG_DATA_HOME/gem";
      GEM_SPEC_CACHE = "$XDG_CACHE_HOME/gem";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
    };

    packages = with pkgs; [
      difftastic
      hugo
      onefetch
      python3
      # swift-format
      tree
      unrar
    ];
  };

  programs = {
    emacs.enable = true;
    home-manager.enable = true; # manage itslef
    pandoc.enable = true;
    texlive.enable = false;
    vscode.enable = true;
    wezterm.enable = false;
    zoxide.enable = true;
  };

  xdg.enable = true;
}
