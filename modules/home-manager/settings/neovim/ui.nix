{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    markview.enable = true;
    dressing.enable = true;
    notify.enable = true;
    noice = {
      enable = true;
      lsp = {
        # signature.enabled = false;
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
            any = [
              { find = "%d+L, %d+B"; }
              { find = "; after #%d+"; }
              { find = "; before #%d+"; }
            ];
          };
          view = "mini";
        }
      ];
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
      enable = false;
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

    lualine = {
      enable = false;
      package = pkgs.vimPlugins.lualine-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            mv $out/lua/lualine/themes/nord.lua $out/lua/lualine/themes/nord-builtin.lua
          '';
      });
      settings = {
        options = {
          disabled_filetypes.statusline = [
            "dap-repl"
            "dashboard"
          ];
          globalstatus = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            "diagnostics"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
        extensions = [
          "aerial"
          "man"
          "nvim-dap-ui"
          "neo-tree"
          "overseer"
          "quickfix"
          "toggleterm"
        ];
      };
    };

    rainbow-delimiters.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        exclude.filetypes = [
          "conf"
          "dashboard"
          "markdown"
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
        "hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)";
    };

    twilight.enable = true;
    zen-mode = {
      enable = true;
      settings.plugins.gitsigns.enabled = false;
    };

    web-devicons.enable = true;

    mini = {
      enable = false;
      mockDevIcons = true;
      modules.icons = {
        lsp = {
          "function".glyph = "";
          object.glyph = "";
          value.glyph = "";
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>tn";
      action.__raw =
        # lua
        ''function() require("notify").dismiss({ silent = true, pending = true }) end'';
      options.desc = "Delete All Notifications";
    }

    {
      mode = [
        "n"
        "i"
        "s"
      ];
      key = "<C-f>";
      action.__raw =
        # lua
        ''function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end'';
      options.silent = true;
      options.expr = true;
    }
    {
      mode = [
        "n"
        "i"
        "s"
      ];
      key = "<C-b>";
      action.__raw =
        # lua
        ''function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end'';
      options.silent = true;
      options.expr = true;
    }
  ];
}
