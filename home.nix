{
  pkgs,
  lib,
  ...
}:
{

  home.username = "jia";
  home.homeDirectory = "/Users/jia";

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop
    bat
    cargo
    delta
    fastfetch
    fd
    fish
    fzf
    lazygit
    nodejs
    python3
    ripgrep
    tree-sitter
    yazi
  ];

  xdg.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "bamboo";
      italic-text = "always";
      style = "numbers,changes,header";
    };
  };

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./home-modules/bat-themes;
    onChange = "${pkgs.bat} cache --build";
  };

  programs.git = {
    enable = true;
    userName = "Jia Jia";
    userEmail = "mathjiajia@outlook.com";
    extraConfig = {
      github.user = "mathyjiajia";
      init = {
        defaultBranch = "trunk";
      };
      diff = {
        external = "${pkgs.difftastic}/bin/difft";
      };
    };
  };
}
