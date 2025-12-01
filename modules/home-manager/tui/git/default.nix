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
      line-numbers = true;
      navigate = true;
      side-by-side = false;
      syntax-theme = "bamboo";
      decorations = {
        file-decoration-style = "bold yellow ul";
        file-style = "purple bold";
        hunk-header-decoration-style = "yellow box ul";
        hunk-header-file-style = "yellow";
        hunk-header-line-number-style = "grey bold italic";
        hunk-header-style = "line-number syntax italic";
        line-numbers-minus-style = "red bold italic";
        line-numbers-plus-style = "green bold italic";
        line-numbers-zero-style = "grey italic";
        minus-emph-style = "syntax auto";
        minus-style = "syntax auto";
        zero-style = "syntax";
      };
    };
  };
  # programs.difftastic = {
  #   enable = true;
  #   git = {
  #     enable = true;
  #     diffToolMode = true;
  #   };
  # };

  programs.lazygit = {
    enable = true;
    settings = {
      # git.pagers = [ { externalDiffCommand = "${pkgs.difftastic}/bin/difft --color=always"; } ];
      git.pagers = [ { pager = "${lib.getExe pkgs.delta} --dark --paging=never"; } ];
      gui = {
        nerdFontsVersion = "3";
        sidePanelWidth = 0.25;
        tabWidth = 2;
      };
    };
  };

  programs.gitui = {
    # enable = true;
    keyConfig = ''
      (
        open_help: Some(( code: F(1), modifiers: "")),

        move_left: Some(( code: Char('h'), modifiers: "")),
        move_right: Some(( code: Char('l'), modifiers: "")),
        move_up: Some(( code: Char('k'), modifiers: "")),
        move_down: Some(( code: Char('j'), modifiers: "")),

        popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
        popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
        page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
        page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
        home: Some(( code: Char('g'), modifiers: "")),
        end: Some(( code: Char('G'), modifiers: "SHIFT")),
        shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
        shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

        edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

        status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

        diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
        diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

        stashing_save: Some(( code: Char('w'), modifiers: "")),
        stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

        stash_open: Some(( code: Char('l'), modifiers: "")),

        abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
      )
    '';
  };
}
