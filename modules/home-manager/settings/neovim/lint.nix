{ ... }:
{
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      bash = [ "shellcheck" ];
      fish = [ "fish" ];
      gitcommit = [ "commitlint" ];
      markdown = [ "markdownlint-cli2" ];
      zsh = [ "shellcheck" ];
    };
  };
}
