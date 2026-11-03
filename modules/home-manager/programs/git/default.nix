{ lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    package = null;
    settings = {
      core.editor = "nvim";
      user = {
        email = "mathjiajia@outlook.com";
        name = "Jia Jia";
      };
      fetch.prune = true;
      github.user = "mathjiajia";
      log.date = "iso";
      merge.conflictstyle = "zdiff3";
      pager.difftool = true;
      push.autoSetupRemote = true;
    };
    ignores = lib.splitString "\n" (builtins.readFile ./global.gitignore);
  };

  programs.difftastic = {
    enable = true;
    git.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.diffRenderers = [
        {
          type = "extDiff";
          command = "${lib.getExe pkgs.difftastic} --color=always --context={{diffContext}}";
        }
      ];
      gui = {
        nerdFontsVersion = "3";
        sidePanelWidth = 0.25;
        tabWidth = 2;
      };
    };
  };
}
