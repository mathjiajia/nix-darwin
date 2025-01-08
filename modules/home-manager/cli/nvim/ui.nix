{pkgs, ...}: {
  programs.nixvim.plugins = {
    markview = {
      enable = true;
      settings.filetypes = ["markdown" "rmd" "codecompanion"];
    };
    rainbow-delimiters.enable = true;
    snacks = {
      enable = true;
      package = pkgs.vimPlugins.snacks-nvim.overrideAttrs {
        postInstall =
          # sh
          ''
            rm -rf $out/queries
          '';
      };
      settings = {
        dashboard = {
          enabled = true;
          preset = {
            header = ''
              ██████████████████████████████████████████████████
              █████ ████████████████████████████████████████
              ████   ███  ████████████████  █ ███████████
              ███     █     █     ██  ████ █ ███
              ██  █       ██ ██    █        ██
              ██  ███   █   ██ ██ █   █  █ █  ██
              ███████ ██    █    ███ █  █████ ██
              ██████████████████████████████████████████████████
            '';
            keys = [
              {
                icon = " ";
                key = "f";
                desc = "Find File";
                action = ":FzfLua files";
              }
              {
                icon = " ";
                key = "n";
                desc = "New File";
                action = ":ene | startinsert";
              }
              {
                icon = " ";
                key = "g";
                desc = "Find Text";
                action = ":FzfLua live_grep";
              }
              {
                icon = " ";
                key = "r";
                desc = "Recent Files";
                action = ":FzfLua oldfiles";
              }
              {
                icon = " ";
                key = "q";
                desc = "Quit";
                action = ":qa";
              }
            ];
          };
          formats.key.__raw =
            # lua
            ''
              function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end
            '';
          sections = [
            {section = "header";}
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Recent Files";
              section = "recent_files";
              indent = 2;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Projects";
              section = "projects";
              indent = 2;
              padding = 1;
            }
            {
              pane = 2;
              icon = " ";
              title = "Git Status";
              section = "terminal";
              enabled.__raw =
                # lua
                ''
                  Snacks.git.get_root() ~= nil
                '';
              cmd = "git status --short --branch --renames";
              height = 5;
              padding = 1;
              ttl = 5 * 60;
              indent = 2;
            }
          ];
        };
        indent = {
          enabled = true;
          scope.hl = [
            "RainbowDelimiterRed"
            "RainbowDelimiterYellow"
            "RainbowDelimiterBlue"
            "RainbowDelimiterOrange"
            "RainbowDelimiterGreen"
            "RainbowDelimiterViolet"
            "RainbowDelimiterCyan"
          ];
        };
        input.enabled = true;
        notifier.enabled = true;
        scroll.enabled.__raw =
          #
          ''
            not vim.g.neovide
          '';
        scope.enabled = true;
        # statuscolumn.enabled = true;
        words.enabled = true;
        styles = {
          lazygit = {
            width = 0;
            height = 0;
          };
          notification.wo.wrap = true;
          terminal.height = 12;
        };
      };
      luaConfig.post =
        # lua
        ''
          Snacks.toggle.zen():map("<leader>z")
          Snacks.toggle.zoom():map("<leader>Z")
        '';
    };
    noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
        routes = [
          {
            filter = {
              event = "msg_show";
              any = [{find = "%d+L, %d+B";} {find = "; after #%d+";} {find = "; before #%d+";}];
            };
            view = "mini";
          }
        ];
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>.";
      action.__raw =
        # lua
        ''
          function() Snacks.scratch() end
        '';
      options.desc = "Toggle Scratch Buffer";
    }
    {
      key = "<leader>S";
      action.__raw =
        # lua
        ''
          function() Snacks.scratch.select() end
        '';
      options.desc = "Select Scratch Buffer";
    }

    {
      key = "<leader>n";
      action.__raw =
        # lua
        ''
          function() Snacks.notifier.show_history() end
        '';
      options.desc = "Notification History";
    }
    {
      key = "<leader>un";
      action.__raw =
        # lua
        ''
          function() Snacks.notifier.hide() end
        '';
      options.desc = "Dismiss All Notifications";
    }

    {
      key = "<leader>bd";
      action.__raw =
        # lua
        ''
          function() Snacks.bufdelete() end
        '';
      options.desc = "Delete Buffer";
    }
    {
      key = "<leader>bD";
      action.__raw =
        # lua
        ''
          function() Snacks.bufdelete.other() end
        '';
      options.desc = "Delete Other Buffers";
    }

    {
      key = "<leader>gf";
      action.__raw =
        # lua
        ''
          function() Snacks.lazygit.log_file() end
        '';
      options.desc = "Lazygit Current File History";
    }
    {
      key = "<leader>gg";
      action.__raw =
        # lua
        ''
          function() Snacks.lazygit() end
        '';
      options.desc = "Lazygit";
    }

    {
      key = "<leader>cR";
      action.__raw =
        # lua
        ''
          function() Snacks.rename.rename_file() end
        '';
      options.desc = "Rename File";
    }

    {
      mode = ["n" "t"];
      key = "<C-Bslash>";
      action.__raw =
        # lua
        ''
          function() Snacks.terminal() end
        '';
      options.desc = "Toggle Terminal";
    }

    {
      mode = ["n" "i" "s"];
      key = "<C-f>";
      action.__raw =
        # lua
        ''
          function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end
        '';
      options.silent = true;
      options.expr = true;
    }
    {
      mode = ["n" "i" "s"];
      key = "<C-b>";
      action.__raw =
        # lua
        ''
          function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end
        '';
      options.silent = true;
      options.expr = true;
    }
  ];
}
