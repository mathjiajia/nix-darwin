{ ... }:
{

  home.username = "jia";
  home.homeDirectory = "/Users/jia";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ensures ~/Developer folder exists.
  # this folder is later assumed by other activations, specially on darwin.
  home.activation.developer = ''
    mkdir -p ~/Developer
  '';

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs = {
    btop.enable = true;
    emacs.enable = true;
    fastfetch.enable = true;
    lazygit.enable = true;
    ripgrep.enable = true;
  };

  xdg.enable = true;
}
