{
  programs.nixvim.colorschemes = {
    tokyonight = {
      enable = true;
      settings = {
        style = "moon";
        dim_inactive = true;
        transparent = false;
        terminal_colors = false;
        plugins = {
          all = false;
          auto = false;
          aerial = true;
          blink = true;
          dap = true;
          flash = true;
          gitsigns = true;
          grug-far = true;
          mini_diff = true;
          mini_hipatterns = true;
          mini_icons = true;
          rainbow = true;
          render-markdown = true;
          snacks = true;
          treesitter_context = true;
        };
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
