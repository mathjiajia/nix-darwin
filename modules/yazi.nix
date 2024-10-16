{ config, ... }:
# let
#   yaziPlugins = pkgs.fetchFromGitHub {
#     owner = "yazi-rs";
#     repo = "plugins";
#     rev = "...";
#     hash = "sha256-...";
#   };
# in
{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [
          1
          2
          3
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 1200;
        max_height = 1500;
        cache_dir = "${config.xdg.cacheHome}";
      };
    };
    # plugins = {
    # diff = "${yaziPlugins}/diff.yazi";
    # full-border = "${yaziPlugins}/full-border.yazi";
    # jump-to-char = "${yaziPlugins}/jump-to-char.yazi";
    # smart-filter = "${yaziPlugins}/smart-filter.yazi";
    # glow = pkgs.fetchFromGitHub {
    #   owner = "Reledia";
    #   repo = "glow.yazi";
    #   rev = "...";
    #   sha256 = "sha256-...";
    # };
    # };
    initLua = ''
      require("full-border"):setup()
    '';
    keymap = {
      manager.prepend_keymap = [
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
          on = "<C-d>";
          run = "plugin diff";
          desc = "Diff the selected with the hovered file";
        }

        # lazygit
        {
          on = "<A-g>";
          run = "shell --block --confirm 'lazygit'";
          desc = "Run lazygit";
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
  };
}
