{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      transparent_background = true;
      float.transparent = true;
      term_colors = true;
      custom_highlights.__raw = ''
        function(C)
          return {
            MiniStatuslineDevinfo = { fg = C.subtext1, bg = "NONE" },
            MiniStatuslineFileinfo = { fg = C.subtext1, bg = "NONE" },
            MiniStatuslineFilename = { fg = C.text, bg = "NONE" },
            MiniStatuslineInactive = { fg = C.blue, bg = "NONE" },
            MiniStatuslineModeCommand = { fg = C.peach, bg = "NONE", style = { "bold" } },
            MiniStatuslineModeInsert = { fg = C.green, bg = "NONE", style = { "bold" } },
            MiniStatuslineModeNormal = { fg = C.blue, bg = "NONE", style = { "bold" } },
            MiniStatuslineModeOther = { fg = C.teal, bg = "NONE", style = { "bold" } },
            MiniStatuslineModeReplace = { fg = C.red, bg = "NONE", style = { "bold" } },
            MiniStatuslineModeVisual = { fg = C.mauve, bg = "NONE", style = { "bold" } },
          }
        end
      '';
      # When upgrading from 2.0.0, replace default_integrations = false with
      # auto_integrations = false:
      default_integrations = false;
      integrations = {
        blink_cmp = {
          enabled = true;
          style = "bordered";
        };
        blink_indent = true;
        blink_pairs = true;
        dap = true;
        dap_ui = true;
        dropbar = {
          enabled = true;
          color_mode = true;
        };
        flash = true;
        grug_far = true;
        mini.enabled = true;
        nvim_surround = true;
        overseer = true;
        snacks.enabled = true;
      };
    };
  };
}
