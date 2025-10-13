{
  programs.nixvim.colorschemes = {
    bamboo = {
      enable = true;
      settings = {
        transparent = true;
        dim_inactive = true;
        code_style.comments = {
          italic = true;
          fg = "#5b5e5a";
        };
        highlights = {
          CursorLine.bg = "$bg2";
          StatusLine.bg = "$none";
          BlinkPairsBlue.fg = "$blue";
          BlinkPairsYellow.fg = "$yellow";
          BlinkPairsGreen.fg = "$green";
          BlinkPairsTeal.fg = "$cyan";
          BlinkPairsMagenta.fg = "$coral";
          BlinkPairsPurple.fg = "$purple";
          BlinkPairsOrange.fg = "$orange";
        };
      };
    };
    tokyonight = {
      # enable = true;
      settings = {
        style = "moon";
        dim_inactive = true;
        transparent = true;
        terminal_colors = false;
        plugins = {
          all = false;
          auto = false;
          blink = true;
          dap = true;
          flash = true;
          gitsigns = true;
          grug-far = true;
          mini_hipatterns = true;
          mini_icons = true;
          render-markdown = true;
          snacks = true;
          treesitter_context = true;
        };
        on_highlights =
          # lua
          ''
            function(hl, c)
            	hl["@module.latex"] = { fg = c.yellow }
            	hl["@label.latex"] = { fg = c.blue }
            	hl["@function.latex"] = { fg = c.magenta }
            	hl.BlinkPairsBlue = { fg = c.blue }
            	hl.BlinkPairsYellow = { fg = c.yellow }
            	hl.BlinkPairsGreen = { fg = c.green }
            	hl.BlinkPairsTeal = { fg = c.teal }
            	hl.BlinkPairsMagenta = { fg = c.magenta }
            	hl.BlinkPairsPurple = { fg = c.purple }
            	hl.BlinkPairsOrange = { fg = c.orange }
            end
          '';
      };
    };

    kanagawa-paper = {
      # enable = true;
      settings = {
        dim_inactive = true;
        terminal_colors = false;
        cache = true;
        styles = {
          functions.italic = true;
          keywords = {
            italic = true;
            bold = true;
          };
          statement_style = {
            italic = true;
            bold = true;
          };
        };
        auto_plugins = false;
        all_plugins = false;
        plugins = {
          aerial = true;
          barbar = false;
          blink = true;
          bufferline = false;
          flash = true;
          floaterm = false;
          gitgutter = false;
          gitsigns = true;
          grug_far = true;
          headlines = false;
          incline = false;
          indent_blankline = false;
          lazy = false;
          leap = false;
          mini = true;
          neo_tree = false;
          neogit = false;
          neotest = false;
          noice = false;
          nvim_cmp = false;
          nvim_dap_ui = true;
          nvim_navic = false;
          nvim_notify = false;
          nvim_spectre = false;
          nvim_tree = false;
          nvim_treesitter_context = true;
          nvim_window_picker = false;
          octo = false;
          overseer = true;
          rainbow_delimiters = true;
          render_markdown = true;
          satellite = false;
          snacks = true;
          telescope = false;
          trouble = false;
          which_key = false;
          yanky = false;
        };
      };
    };
  };
}
