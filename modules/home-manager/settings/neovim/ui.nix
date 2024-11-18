{pkgs, ...}: {
  programs.nixvim.plugins = {
    markview.enable = true;
    dressing.enable = true;
    snacks = {
      enable = true;
      package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "snacks.nvim";
          rev = "master";
          hash = "sha256-VpgZbCf1j2uyg8d4olQYm+GWkaWnFPwCSWOZ/2Jm0Us=";
        };
        postInstall =
          (oldAttrs.postInstall or "")
          +
          # sh
          ''
            rm -rf $out/queries
          '';
      });
      settings = {
        bigfile.enabled = false;
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        quickfile.enabled = false;
        statuscolumn.enabled = false;
        words.enabled = false;
        styles.notification.wo.wrap = true;
      };
    };
    noice = {
      enable = true;
      package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "noice.nvim";
          rev = "master";
          hash = "sha256-rUjtm8rFuXMowBYfJIzk/tQJ5jdZ9+Ke3c/d0uW8iUE=";
        };
      });
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

    dashboard = {
      enable = true;
      settings = {
        config = {
          footer = [
            ""
            "Powered by nixvim!"
          ];
          header = [
            ""
            "                                                                     "
            "       ████ ██████           █████      ██                     "
            "      ███████████             █████                             "
            "      █████████ ███████████████████ ███   ███████████   "
            "     █████████  ███    █████████████ █████ ██████████████   "
            "    █████████ ██████████ █████████ █████ █████ ████ █████   "
            "  ███████████ ███    ███ █████████ █████ █████ ████ █████  "
            " ██████  █████████████████████ ████ █████ █████ ████ ██████ "
            ""
            ""
          ];
          mru.cwd_only = true;
          packages.enable = false;
          project.action = "FzfLua files cwd=";
          shortcut = [
            {
              action = "FzfLua files";
              desc = "Find File";
              group = "Directory";
              icon = "  ";
              key = "ff";
            }
            {
              action = "FzfLua oldfiles";
              desc = "Recent Files";
              group = "Identifier";
              icon = "  ";
              key = "fo";
            }
            {
              action = "FzfLua live_grep";
              desc = "Live Grep";
              group = "Float";
              icon = "  ";
              key = "sg";
            }
            {
              action.__raw = ''function(path) vim.api.nvim_input("<Cmd>qa<CR>") end'';
              desc = "Quit";
              group = "String";
              icon = "  ";
              key = "q";
            }
          ];
        };
      };
    };

    bufferline = {
      enable = true;
      settings = {
        options = {
          always_show_bufferline = false;
          diagnostics = "nvim_lsp";
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
        exclude.filetypes = ["conf" "dashboard" "markdown"];
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

    mini = {
      enable = true;
      package = pkgs.vimPlugins.mini-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          +
          # sh
          ''
            rm -rf $out/doc/mini-cursorword.txt
          '';
      });
      mockDevIcons = true;
      modules = {
        hipatterns = {
          highlighters = {
            fixme = {
              pattern = "%f[%w]()FIXME()%f[%W]";
              group = "MiniHipatternsFixme";
              extmark_opts = {
                sign_text = "";
                sign_hl_group = "DiagnosticError";
              };
            };
            hack = {
              pattern = "%f[%w]()HACK()%f[%W]";
              group = "MiniHipatternsHack";
              extmark_opts = {
                sign_text = "";
                sign_hl_group = "DiagnosticWarn";
              };
            };
            todo = {
              pattern = "%f[%w]()TODO()%f[%W]";
              group = "MiniHipatternsTodo";
              extmark_opts = {
                sign_text = "";
                sign_hl_group = "DiagnosticInfo";
              };
            };
            note = {
              pattern = "%f[%w]()NOTE()%f[%W]";
              group = "MiniHipatternsNote";
              extmark_opts = {
                sign_text = "";
                sign_hl_group = "DiagnosticHint";
              };
            };
            hex_color.__raw =
              # lua
              ''
                require('mini.hipatterns').gen_highlighter.hex_color()
              '';
          };
        };
        icons.lsp = {
          "function".glyph = "";
          object.glyph = "";
          value.glyph = "";
        };
        statusline = {};
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>un";
      action.__raw =
        # lua
        ''
          function()
          	require("snacks.notifier").hide()
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
          	require("snacks.bufdelete")()
          end
        '';
      options.desc = "Delete Buffer";
    }

    {
      key = "<leader>gg";
      action.__raw =
        # lua
        ''
          function()
          	require("snacks.lazygit")()
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
          	require("snacks.lazygit").log_file()
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
          	require("snacks.rename")()
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
          	require("snacks.terminal")()
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
