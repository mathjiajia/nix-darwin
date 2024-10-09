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
    emacs.enable = true;
    home-manager.enable = true;
    vscode.enable = true;
  };

  xdg.enable = true;
}
