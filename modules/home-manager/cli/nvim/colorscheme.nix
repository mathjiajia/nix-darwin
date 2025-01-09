{
  programs.nixvim.colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        integrations = {
          aerial = true;
          alpha = false;
          blink_cmp = true;
          cmp = false;
          dashboard = false;
          dropbar.enabled = true;
          grug_far = true;
          neogit = false;
          noice = true;
          nvimtree = false;
          nvim_surround = true;
          overseer = true;
          render_markdown = false;
          snacks = true;
          ufo = false;

          colorful_winsep.enabled = true;
          illuminate.enabled = false;
          telescope.enabled = false;
        };
        color_overrides = {
          latte = {
            rosewater = "#c14a4a";
            flamingo = "#c14a4a";
            red = "#9d0006";
            maroon = "#c14a4a";
            pink = "#8f3f71";
            mauve = "#945e80";
            peach = "#af3a03";
            yellow = "#b57614";
            green = "#79740e";
            teal = "#427b58";
            sky = "#4c7a5d";
            sapphire = "#4c7a5d";
            blue = "#076678";
            lavender = "#45707a";
            text = "#654735";
            subtext1 = "#73503c";
            subtext0 = "#805942";
            overlay2 = "#8c6249";
            overlay1 = "#8c856d";
            overlay0 = "#a69d81";
            surface2 = "#bfb695";
            surface1 = "#d1c7a3";
            surface0 = "#e3dec3";
            base = "#f9f5d7";
            mantle = "#f0ebce";
            crust = "#e8e3c8";
          };
          mocha = {
            rosewater = "#ea6962";
            flamingo = "#ea6962";
            red = "#ea6962";
            maroon = "#ea6962";
            pink = "#d3869b";
            mauve = "#d3869b";
            peach = "#e78a4e";
            yellow = "#d8a657";
            green = "#a9b665";
            teal = "#8ec07c";
            sky = "#89b482";
            sapphire = "#89b482";
            blue = "#83a598";
            lavender = "#7daea3";
            text = "#ebdbb2";
            subtext1 = "#d5c4a1";
            subtext0 = "#bdae93";
            overlay2 = "#a89984";
            overlay1 = "#928374";
            overlay0 = "#595959";
            surface2 = "#4d4d4d";
            surface1 = "#404040";
            surface0 = "#292929";
            base = "#1d2021";
            mantle = "#191b1c";
            crust = "#141617";
          };
        };
        custom_highlights =
          # lua
          ''
            function(colors)
              return {
                BlinkCmpMenu = { fg = colors.text },
                BlinkCmpMenuBorder = { fg = colors.blue },
                BlinkCmpLabelMatch = { fg = colors.lavender },
                BlinkCmpKind = { fg = colors.blue },
                BlinkCmpDocBorder = { fg = colors.blue },
                BlinkCmpSignatureHelpBorder = { fg = colors.blue },
                BlinkCmpSignatureHelpActiveParameter = { fg = colors.mauve },
              }
            end
          '';
        term_colors = true;
        # transparent_background = true;
      };
    };

    nord = {
      # enable = true;
      settings = {
        bold = false;
        borders = true;
        contrast = true;
        cursorline_transparent = true;
        disable_background = false;
        enable_sidebar_background = true;
        italic = true;
        uniform_diff_background = true;
      };
    };

    kanagawa = {
      # enable = true;
      settings = {
        colors.theme.all.ui.bg_gutter = "none";
        compile = true;
        dimInactive = false;
        overrides =
          # lua
          ''
            function(colors)
              return {
                RainbowDelimiterRed = { fg = colors.palette.waveRed },
                RainbowDelimiterYellow = { fg = colors.palette.carpYellow },
                RainbowDelimiterBlue = { fg = colors.palette.dragonBlue },
                RainbowDelimiterOrange = { fg = colors.palette.surimiOrange },
                RainbowDelimiterGreen = { fg = colors.palette.springGreen },
                RainbowDelimiterViolet = { fg = colors.palette.oniViolet },
                RainbowDelimiterCyan = { fg = colors.palette.waveAqua1 },
              }
            end
          '';
        terminalColors = false;
        transparent = false;
        undercurl = true;
      };
    };

    rose-pine = {
      # enable = true;
      settings = {
        dark_variant = "main";
        dim_inactive_windows = true;
        enable = {
          legacy_highlights = false;
          migrations = false;
        };
        highlight_groups = {};
        styles.transparency = true;
        variant = "auto";
      };
    };
  };
}
