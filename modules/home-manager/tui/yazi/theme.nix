{ pkgs, ... }:
let
  yazi-flavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "20b47bfd78880c2674899597fd26bc01b21ff48c";
    hash = "sha256-NGnfrQdsnQITKCZ0oh6DCxeCR2ozJoPAZetsi3ghHAI=";
  };
in
{
  programs.yazi = {
    flavors = {
      catppuccin-latte = "${yazi-flavors}/catppuccin-latte.yazi";
      catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
    };
    theme.flavor = {
      dark = "catppuccin-mocha";
      light = "catppuccin-latte";
    };
  };
}
