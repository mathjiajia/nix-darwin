{ pkgs, ... }:
let
  yaziPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "4fcd737db5f6cd4b5d6645659b16d891e1d93dd3";
    sha256 = "NNfPwiY1J+s/b2rajEdAubGsGKfFCA5ALz7MNX8wyGM=";
  };
in
# mdcatPlugin = pkgs.fetchFromGitHub {
#   owner = "GrzegorzKozub";
#   repo = "mdcat";
#   rev = "1706af432dbd75b2a60951137290c6b0f62909da";
#   sha256 = "wy934gll5axi34bdhi4kzjf7lx3vzn25=";
# };
{
  programs.yazi.plugins = {
    arrow = ./arrow.yazi;
    chmod = "${yaziPlugins}/chmod.yazi";
    diff = "${yaziPlugins}/diff.yazi";
    full-border = "${yaziPlugins}/full-border.yazi";
    git = "${yaziPlugins}/git.yazi";
    jump-to-char = "${yaziPlugins}/jump-to-char.yazi";
    # macat = "${mdcatPlugin}";
    parent-arrow = ./parent-arrow.yazi;
    smart-enter = ./smart-enter.yazi;
    smart-filter = "${yaziPlugins}/smart-filter.yazi";
  };
}
