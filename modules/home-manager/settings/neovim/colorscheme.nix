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
        colors = {theme = {all = {ui = {bg_gutter = "none";};};};};
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
