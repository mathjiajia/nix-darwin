{ neovim-nightly-overlay, pkgs, ... }:
{

  home.username = "jia";
  home.homeDirectory = "/Users/jia";

  home.stateVersion = "24.11";

  home.sessionVariables = {
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    DFT_PARSE_ERROR_LIMIT = 999;
    HOMEBREW_NO_ANALYTICS = 1;
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
    viAlias = true;
    vimAlias = true;
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
    ./fish.nix
    ./fzf.nix
    ./kitty.nix
    ./neovide.nix
    ./ripgrep.nix
    ./sioyek.nix
    ./starship.nix
    ./yazi.nix
  ];
}
