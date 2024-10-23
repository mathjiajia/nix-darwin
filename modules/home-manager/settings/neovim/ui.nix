{ ... }:
{
  programs.nixvim.plugins = {
    notify.enable = true;
    noice = {
      enable = true;
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
      luaConfig.pre = ''
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
      luaConfig.post = ''
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      '';
    };

    twilight.enable = true;
    zen-mode = {
      enable = true;
      settings = {
        plugins.gitsigns.enabled = false;
      };
    };

    mini = {
      enable = true;
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
}
