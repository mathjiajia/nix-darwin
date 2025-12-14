{ pkgs, ... }:
{
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    full-border = pkgs.yaziPlugins.full-border;
    git = pkgs.yaziPlugins.git;
  };
}
