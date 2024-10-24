{ lib, ... }:
{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = lib.strings.stringToCharacters "git";
        run = "shell --block --confirm 'lazygit'";
        desc = "Open the selected files";
      }
      {
        on = "j";
        run = "plugin --sync arrow --args=1";
        desc = "Move cursor down";
      }
      {
        on = "k";
        run = "plugin --sync arrow --args=-1";
        desc = "Move cursor up";
      }

      {
        on = "J";
        run = "plugin --sync parent-arrow --args=1";
        desc = "Move cursor down in the parent dir";
      }
      {
        on = "K";
        run = "plugin --sync parent-arrow --args=-1";
        desc = "Move cursor up in the parent dir";
      }

      {
        on = "l";
        run = "plugin --sync smart-enter";
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
        run = "cd ~/.config/nvim";
        desc = "Go to the nvim config directory";
      }
      {
        on = [
          "g"
          "t"
        ];
        run = "cd ~/Documents/Talks";
        desc = "Go to the talks directory";
      }
      {
        on = [
          "g"
          "v"
        ];
        run = "cd ~/.config/vimtex";
        desc = "Go to the yazi config directory";
      }
      {
        on = [
          "g"
          "x"
        ];
        run = "cd ~/.config/nix-darwin";
        desc = "Go to the nix-darwin config directory";
      }

      # Operation
      {
        on = "<Backspace>";
        run = "remove";
        desc = "Move the files to the trash";
      }

      # { on = "f"; run = "plugin jump-to-char"; desc = "Jump to char"; }
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
