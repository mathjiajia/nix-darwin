{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      transparent_background = true;
      float.transparent = true;
      term_colors = true;
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
