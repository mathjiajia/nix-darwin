{ lib, pkgs, ... }:
{
  home.shellAliases = {
    gd = "git diff";
    gP = "git push";
    gp = "git pull";
  };

  programs.git = {
    enable = true;
    package = null;
    settings = {
      user = {
        email = "mathjiajia@outlook.com";
        name = "Jia Jia";
      };
      core = {
        commitGraph = true;
        editor = "nvim";
      };
      fetch.prune = true;
      github.user = "mathjiajia";
      log.date = "iso";
      merge.conflictstyle = "zdiff3";
      pager.difftool = true;
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoSquash = true;
    };
    ignores = lib.splitString "\n" (builtins.readFile ./global_ignore);
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "decorations";
      navigate = true;
      side-by-side = false;
      decorations = {
        syntax-theme = "bamboo";
        hunk-header-decoration-style = "'#5E81AC' ul";
        hunk-header-file-style = "blue ul bold";
        hunk-header-line-number-style = "yellow box bold";
        hunk-header-style = "file line-number syntax bold italic";
        plus-style = "brightgreen";
        plus-emph-style = "black green";
        minus-style = "brightred";
        minus-emph-style = "black red";
        line-numbers = true;
        line-numbers-minus-style = "brightred";
        line-numbers-plus-style = "brightgreen";
        whitespace-error-style = "black bold";
        merge-conflict-ours-diff-header-style = "yellow bold";
        merge-conflict-ours-diff-header-decoration-style = "'#5E81AC' box";
        merge-conflict-theirs-diff-header-style = "yellow bold";
        merge-conflict-theirs-diff-header-decoration-style = "'#5E81AC' box";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.pagers = [ { pager = "${lib.getExe pkgs.delta} --dark --paging=never"; } ];
      gui = {
        nerdFontsVersion = "3";
        sidePanelWidth = 0.25;
        tabWidth = 2;
      };
    };
  };
}
