{lib, ...}: {
  programs.git = {
    enable = true;
    difftastic.enable = true;
    userName = "Jia Jia";
    userEmail = "mathjiajia@outlook.com";
    extraConfig = {
      core.editor = "nvim";
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
  # programs.gitui.enable = true;
}
