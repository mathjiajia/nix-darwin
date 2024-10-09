{ ... }:
{

  home.username = "jia";
  home.homeDirectory = "/Users/jia";

  home.stateVersion = "24.05";

  home.sessionVariables = {
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
    DFT_PARSE_ERROR_LIMIT = 999;
    HOMEBREW_NO_ANALYTICS = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ensures ~/Developer folder exists.
  # this folder is later assumed by other activations, specially on darwin.
  home.activation.developer = ''
    mkdir -p ~/Developer
  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs = {
    btop.enable = true;
    emacs.enable = true;
    fastfetch.enable = true;
    ripgrep.enable = true;
  };

  xdg.enable = true;
}
