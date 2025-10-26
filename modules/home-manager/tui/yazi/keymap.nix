{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = [
          "g"
          "f"
        ];
        run = "plugin vcs-files";
        desc = "Show Git file changes";
      }
      {
        on = [
          "g"
          "i"
        ];
        run = "shell --block --confirm 'lazygit'";
        desc = "Open lazygit";
      }

      {
        on = "J";
        run = "plugin parent-arrow 1";
      }
      {
        on = "K";
        run = "plugin parent-arrow -1";
      }

      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter the child directory; or open the file";
      }

      # Goto
      {
        on = [
          "g"
          "m"
        ];
        run = "cd ~/Documents/Projects/moduli2";
        desc = "Go to the current project dir";
      }
      {
        on = [
          "g"
          "n"
        ];
        run = "cd ~/.config/nix-darwin";
        desc = "Go to the nix-darwin config directory";
      }
      {
        on = [
          "g"
          "r"
        ];
        run = "cd ~/Documents/Review";
        desc = "Go to the review directory";
      }
      {
        on = [
          "g"
          "t"
        ];
        run = "cd ~/Documents/Talks";
        desc = "Go to the talks directory";
      }

      # Operation
      {
        on = "<Backspace>";
        run = "remove";
        desc = "Move the files to the trash";
      }

      {
        on = "F";
        run = "plugin smart-filter";
        desc = "Smart filter";
      }
      {
        on = [
          "c"
          "m"
        ];
        run = "plugin chmod";
        desc = "Chmod selected files";
      }
      {
        on = "<C-d>";
        run = "plugin diff";
        desc = "Diff the selected with the hovered file";
      }
    ];

    input.prepend_keymap = [
      {
        on = "<C-c>";
        run = "close";
        desc = "Cancel input";
      }
    ];
  };
}
