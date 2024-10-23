{ pkgs, ... }:
{
  imports = [
    ./settings/bat
    ./settings/git
    ./settings/neovim

    ./settings/fastfetch.nix
    ./settings/fd.nix
    ./settings/fish.nix
    ./settings/fzf.nix
    ./settings/kitty.nix
    ./settings/neovide.nix
    ./settings/ripgrep.nix
    ./settings/sioyek.nix
    ./settings/starship.nix
    ./settings/yazi.nix
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

      # CARGO_HOME = "$XDG_DATA_HOME/cargo";
      DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
      GEM_HOME = "$XDG_DATA_HOME/gem";
      GEM_SPEC_CACHE = "$XDG_CACHE_HOME/gem";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
    };

    packages = with pkgs; [
      cargo
      difftastic
      glow
      hugo
      nixfmt-rfc-style
      onefetch
      python3
      python312Packages.ipython
      poppler
      # swift-format
      tree
      unrar
    ];
  };

  xdg.enable = true;

  programs = {
    emacs.enable = true;
    home-manager.enable = true;
    pandoc.enable = true;
    texlive.enable = false;
    vscode.enable = true;
    wezterm.enable = false;
  };

  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      vim_keys = true;
    };
  };

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   withPython3 = false;
  #   withRuby = false;
  #   package = neovim-nightly-overlay.packages.${pkgs.system}.default;
  # };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

}
