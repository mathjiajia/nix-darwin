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
      core = {
        commitGraph = true;
        editor = "nvim";
      };
      user = {
        email = "mathjiajia@outlook.com";
        name = "Jia Jia";
      };
      credential.helper = "osxkeychain";
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
        dark = true;
        syntax-theme = "Nord";

        file-added-label = "[+]";
        file-copied-label = "[==]";
        file-modified-label = "[*]";
        file-removed-label = "[-]";
        file-renamed-label = "[->]";
        file-style = "omit";

        hunk-header-decoration-style = "#5E81AC ul";
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
        line-numbers-left-style = "#5E81AC";
        line-numbers-right-style = "#5E81AC";
        line-numbers-zero-style = "#4C566A";

        zero-style = "syntax";
        whitespace-error-style = "black bold";

        blame-code-style = "syntax";
        blame-format = "{author:<18} {commit:<6} {timestamp:<15}";
        blame-palette = "#2E3440 #3B4252 #434C5E";

        merge-conflict-begin-symbol = "~";
        merge-conflict-end-symbol = "~";

        merge-conflict-ours-diff-header-style = "yellow bold";
        merge-conflict-ours-diff-header-decoration-style = "#5E81AC box";

        merge-conflict-theirs-diff-header-style = "yellow bold";
        merge-conflict-theirs-diff-header-decoration-style = "#5E81AC box";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.diffRenderers = [ { command = "${lib.getExe pkgs.delta} --dark --paging=never"; } ];
      gui = {
        nerdFontsVersion = "3";
        sidePanelWidth = 0.25;
        tabWidth = 2;
      };
    };
  };
}
