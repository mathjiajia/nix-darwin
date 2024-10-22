{ lib, ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "Jia Jia";
    userEmail = "mathjiajia@outlook.com";
    extraConfig = {
      core.editor = "nvim";
      delta.navigate = true;
      diff = {
        # external = "difft";
        tool = "difftastic";
        colorMoved = "default";
      };
      difftool = {
        difftastic.cmd = "difft $LOCAL $REMOTE";
        prompt = false;
      };
      merge = {
        conflictstyle = "diff3";
        tool = "vimdiff";
      };
      mergetool = {
        keepBackup = false;
        vimdiff.cmd = "nvim -d $LOCAL $MERGED $REMOTE -c 'windo set foldcolumn=0 signcolumn=no wrap | wincmd h'";
      };
      pager.difftool = true;
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoSquash = true;
      github.user = "mathjiajia";
    };
    aliases = {
      a = "add";
      au = "add -u";
      ci = "commit";
      co = "checkout";
      f = "fetch";
      r = "rebase";
      st = "status";
    };
    ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        sidePanelWidth = 0.25;
        nerdFontsVersion = "3";
      };
      git.paging.externalDiffCommand = "difft --color=always --display=inline";
    };
  };
}
