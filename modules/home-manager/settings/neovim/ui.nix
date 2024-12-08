{pkgs, ...}: {
  programs.nixvim.plugins = {
    dressing.enable = true;
    render-markdown.enable = true;
    snacks = {
      enable = true;
      package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          +
          # sh
          ''
            rm -rf $out/queries
          '';
      });
      settings = {
        # bigfile.enabled = true;
        dashboard = {
          enabled = true;
          preset = {
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
              enabled.__raw = ''
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
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        # quickfile.enabled = true;
        # statuscolumn.enabled = true;
        # words.enabled = true;
        styles = {
          lazygit = {
            width = 0;
            height = 0;
          };
          notification.wo = {wrap = true;};
          terminal.height = 12;
        };
      };
    };
    noice = {
      enable = true;
      settings = {
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
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

    lualine = {
      enable = true;
      settings = {
        options = {
          disabled_filetypes.statusline = ["dap-repl" "snacks_dashboard"];
          theme = "catppuccin";
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = [
            "branch"
            {
              __unkeyed-1 = "diff";
              source.__raw =
                # lua
                ''
                  function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                      return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                      }
                    end
                  end,
                '';
            }
          ];
          lualine_c = ["filename"];
          lualine_x = [
            "diagnostics"
            {
              __unkeyed-1 = "filetype";
              icon_only = true;
              separator = "";
              padding = {
                left = 1;
                right = 0;
              };
            }
          ];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
        extensions = ["aerial" "man" "neo-tree" "nvim-dap-ui" "overseer" "quickfix" "toggleterm"];
      };
    };

    bufferline = {
      enable = true;
      settings = {
        options = {
          always_show_bufferline = false;
          diagnostics = "nvim_lsp";
          highlight.__raw =
            # lua
            ''
              require("catppuccin.groups.integrations.bufferline").get()
            '';
          offsets = [
            {
              filetype = "aerial";
              highlight = "Directory";
              text = "Aerial";
              text_align = "left";
            }
            {
              filetype = "neo-tree";
              highlight = "Directory";
              text = "File Explorer";
              text_align = "left";
            }
          ];
        };
      };
    };

    rainbow-delimiters.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        exclude.filetypes = [
          "conf"
          "help"
          "markdown"
          "neo-tree"
          "snacks_dashboard"
          "snacks_nofit"
          "snacks_terminal"
          "snacks_win"
        ];
        scope.highlight = [
          "RainbowRed"
          "RainbowYellow"
          "RainbowBlue"
          "RainbowOrange"
          "RainbowGreen"
          "RainbowViolet"
          "RainbowCyan"
        ];
      };
      luaConfig.pre =
        # lua
        ''
          local hooks = require("ibl.hooks")
          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
          end)
        '';
      luaConfig.post =
        # lua
        ''
          hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        '';
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>un";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.notifier.hide()
          end
        '';
      options.desc = "Dismiss All Notifications";
    }

    {
      key = "<leader>bd";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.bufdelete()
          end
        '';
      options.desc = "Delete Buffer";
    }
    {
      key = "<leader>bD";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.bufdelete.other()
          end
        '';
      options.desc = "Delete Other Buffers";
    }

    {
      key = "<leader>gg";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.lazygit()
          end
        '';
      options.desc = "Lazygit";
    }
    {
      key = "<leader>gf";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.lazygit.log_file()
          end
        '';
      options.desc = "Lazygit Current File History";
    }

    {
      key = "<leader>cR";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.rename.rename_file()
          end
        '';
      options.desc = "Rename File";
    }

    {
      mode = ["n" "t"];
      key = "<C-Bslash>";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.terminal()
          end
        '';
      options.desc = "Toggle Terminal";
    }

    {
      mode = ["n" "i" "s"];
      key = "<C-f>";
      action.__raw =
        # lua
        ''
          function()
            if not require("noice.lsp").scroll(4) then
              return "<C-f>"
            end
          end
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
          function()
          	if not require("noice.lsp").scroll(-4) then
          		return "<C-b>"
          	end
          end
        '';
      options.silent = true;
      options.expr = true;
    }
  ];
}
