{
  inputs,
  neovim-nightly-overlay,
  pkgs,
  ...
}:
{

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
      luajit
      luajitPackages.luarocks
      nixfmt-rfc-style
      nodejs
      onefetch
      python3
      python312Packages.ipython
      poppler
      # swift-format
      tree
      tree-sitter
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  imports = [
    ./bat
    ./git
    ./fastfetch.nix
    ./fd.nix
    ./fish.nix
    ./fzf.nix
    ./kitty.nix
    ./neovide.nix
    # ./nixvim.nix
    ./ripgrep.nix
    ./sioyek.nix
    ./starship.nix
    ./yazi.nix
  ];
}
