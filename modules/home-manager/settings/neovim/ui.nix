{pkgs, ...}: {
  programs.nixvim.plugins = {
    rainbow-delimiters.enable = true;
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
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "snacks.nvim";
          rev = "master";
          hash = "sha256-1SxNVI2IB6LBN+fP82Yb2Wkf3VADtzvlhAFIlzw+Ug4=";
        };
      });
      settings = {
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
        scroll.enabled = true;
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
        '';
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
      # enable = true;
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
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>Z";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.zen.zoom()
          end
        '';
      options.desc = "Toggle Zoom";
    }

    {
      key = "<leader>.";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.scratch()
          end
        '';
      options.desc = "Toggle Scratch Buffer";
    }
    {
      key = "<leader>S";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.scratch.select()
          end
        '';
      options.desc = "Select Scratch Buffer";
    }

    {
      key = "<leader>n";
      action.__raw =
        # lua
        ''
          function()
          	Snacks.notifier.show_history()
          end
        '';
      options.desc = "Notification History";
    }
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
