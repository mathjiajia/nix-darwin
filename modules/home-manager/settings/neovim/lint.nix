{pkgs, ...}: {
  programs.nixvim.extraPackages = with pkgs; [
    commitlint
    markdownlint-cli2
    shellcheck
  ];

  programs.nixvim.plugins.lint = {
    enable = true;
    lazyLoad.settings = {
      ft = ["bash" "fish" "gitcommit" "markdown" "zsh"];
    };
    lintersByFt = {
      bash = ["shellcheck"];
      fish = ["fish"];
      gitcommit = ["commitlint"];
      markdown = ["markdownlint-cli2"];
      zsh = ["shellcheck"];
    };
  };
}
