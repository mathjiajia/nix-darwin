{ lib, pkgs, ... }:
let
  commitWithPi = pkgs.writeShellScript "lazygit-commit-message" (
    builtins.readFile ./lazygit-commit-message.sh
  );
in
{
  programs.git = {
    enable = true;
    package = null;
    settings = {
      core.editor = "nvim";
      diff.tool = "hunk";
      difftool = {
        hunk.cmd = ''${lib.getExe pkgs.hunk} difftool "$LOCAL" "$REMOTE" "$MERGED"'';
        prompt = false;
      };
      user = {
        email = "mathjiajia@outlook.com";
        name = "Jia Jia";
      };
      fetch.prune = true;
      github.user = "mathjiajia";
      log.date = "iso";
      merge.conflictstyle = "zdiff3";
      push.autoSetupRemote = true;
    };
    ignores = lib.splitString "\n" (builtins.readFile ./global.gitignore);
  };

  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "C";
          context = "files";
          description = "Generate commit message with Pi";
          command = "${commitWithPi}";
          output = "terminal";
        }
      ];
      git.diffRenderers = [
        { command = "${lib.getExe pkgs.hunk} pager --theme=github-{{colorScheme}}-default"; }
      ];
      gui = {
        nerdFontsVersion = "3";
        sidePanelWidth = 0.25;
        tabWidth = 2;
      };
    };
  };

  programs.fish.shellAbbrs = {
    gd = "git diff";
    gP = "git push";
    gp = "git pull";
  };
}
