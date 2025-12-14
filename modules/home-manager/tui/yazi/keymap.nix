{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = [
          "g"
          "i"
        ];
        run = "shell --block --confirm 'lazygit'";
        desc = "Open lazygit";
      }

      # Goto
      {
        on = [
          "g"
          "p"
        ];
        run = "cd ~/Documents/Projects";
        desc = "Go to the project dir";
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
          "t"
        ];
        run = "cd ~/Documents/Talks";
        desc = "Go to the talks directory";
      }

      # Operation
      {
        on = [
          "c"
          "m"
        ];
        run = "plugin chmod";
        desc = "Chmod selected files";
      }
    ];
  };
}
