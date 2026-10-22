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
          "a"
        ];
        run = "cd ~/Documents/ChatGPT";
        desc = "Go to AI dir";
      }
      {
        on = [
          "g"
          "n"
        ];
        run = "cd ~/.config/nix-darwin";
        desc = "Go to nix-darwin dir";
      }
      {
        on = [
          "g"
          "p"
        ];
        run = "cd ~/Documents/Projects";
        desc = "Go to projects dir";
      }
      {
        on = [
          "g"
          "r"
        ];
        run = "cd ~/Documents/Review";
        desc = "Go to review dir";
      }
      {
        on = [
          "g"
          "t"
        ];
        run = "cd ~/Documents/Talks";
        desc = "Go to talks dir";
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
