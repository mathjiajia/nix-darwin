{pkgs, ...}: {
  programs.nixvim.colorschemes = {
    catppuccin = {
      enable = true;
      package = pkgs.vimPlugins.catppuccin-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          +
          # sh
          ''
            rm -rf $out/autoload $out/lua/barbecue $out/lua/reactive
          '';
      });
      settings = {
        integrations = {
          aerial = true;
          alpha = false;
          # blink_cmp = true;
          # cmp = false;
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
            red = "#c14a4a";
            maroon = "#c14a4a";
            pink = "#945e80";
            mauve = "#945e80";
            peach = "#c35e0a";
            yellow = "#b47109";
            green = "#6c782e";
            teal = "#4c7a5d";
            sky = "#4c7a5d";
            sapphire = "#4c7a5d";
            blue = "#45707a";
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
            teal = "#89b482";
            sky = "#89b482";
            sapphire = "#89b482";
            blue = "#7daea3";
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
            base = "#191724";
            mantle = "#191b1c";
            crust = "#141617";
          };
        };
        custom_highlights =
          # lua
          ''
            function(colors)
              local C = colors
              -- local O = require("catppuccin").options
              -- local U = require("catppuccin.utils.colors")
              -- local base = not O.transparent_background and colors.base or nil

              return {
                MarkviewBlockQuoteWarn = { fg = C.yellow },
                -- MarkviewBlockQuoteSpecial = {},
                -- MarkviewBlockQuoteNote = {},
                -- MarkviewBlockQuoteDefault = {},
                MarkviewBlockQuoteOk = { fg = C.green },
                MarkviewBlockQuoteError = { fg = C.red },
                -- MarkviewCheckboxCancelled = {},

                -- MarkviewCheckboxChecked = {},
                -- MarkviewCheckboxPending = {},
                -- MarkviewCheckboxProgress = {},
                -- MarkviewCheckboxUnchecked = {},
                -- MarkviewCheckboxStriked = {},
                --
                MarkviewInlineCode = { bg = C.surface0 },
                -- MarkviewCodeInfo = {},
                MarkviewCode = { bg = C.mantle },

                -- MarkviewIcon1 = {},
                -- MarkviewIcon1Sign = {},
                -- MarkviewIcon1Fg = {},
                -- MarkviewIcon2 = {},
                -- MarkviewIcon2Sign = {},
                -- MarkviewIcon2Fg = {},
                -- MarkviewIcon3 = {},
                -- MarkviewIcon3Sign = {},
                -- MarkviewIcon3Fg = {},
                -- MarkviewIcon4 = {},
                -- MarkviewIcon4Sign = {},
                -- MarkviewIcon4Fg = {},
                -- MarkviewIcon5 = {},
                -- MarkviewIcon5Sign = {},
                -- MarkviewIcon5Fg = {},
                -- MarkviewIcon6 = {},
                -- MarkviewIcon6Sign = {},
                -- MarkviewIcon6Fg = {},

                -- MarkviewHeading1Sign = {},
                -- MarkviewHeading1 = { fg = C.red, bg = U.darken(C.red, 0.30, base) },
                -- MarkviewHeading2Sign = {},
                -- MarkviewHeading2 = { fg = C.peach, bg = U.darken(C.peach, 0.30, base) },
                -- MarkviewHeading3Sign = {},
                -- MarkviewHeading3 = { fg = C.yellow, bg = U.darken(C.yellow, 0.30, base) },
                -- MarkviewHeading4Sign = {},
                -- MarkviewHeading4 = { fg = C.green, bg = U.darken(C.green, 0.30, base) },
                -- MarkviewHeading5Sign = {},
                -- MarkviewHeading5 = { fg = C.sapphire, bg = U.darken(C.sapphire, 0.30, base) },
                -- MarkviewHeading6Sign = {},
                -- MarkviewHeading6 = { fg = C.lavender, bg = U.darken(C.lavender, 0.30, base) },

                -- MarkviewGradient1 = {},
                -- MarkviewGradient2 = {},
                -- MarkviewGradient3 = {},
                -- MarkviewGradient4 = {},
                -- MarkviewGradient5 = {},
                -- MarkviewGradient6 = {},
                -- MarkviewGradient7 = {},
                -- MarkviewGradient8 = {},
                -- MarkviewGradient9 = {},
                -- MarkviewGradient10 = {},

                -- MarkviewLatexSubscript = {},
                -- MarkviewLatexSuperscript = {},

                -- MarkviewListItemStar = {},
                -- MarkviewListItemPlus = {},
                -- MarkviewListItemMinus = {},

                -- MarkviewEmail = {},
                -- MarkviewImageLink = {},
                -- MarkviewHyperlink = {},

                -- MarkviewTableHeader = {},
                -- MarkviewTableBorder = {},
                -- MarkviewTableAlignCenter = {},
                -- MarkviewTableAlignLeft = {},
                -- MarkviewTableAlignRight = {},
              }
            end
          '';
        term_colors = true;
        transparent_background = true;
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
