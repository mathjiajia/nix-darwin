{
  # Stored, not imported, with its Rex side in ui_bridge.lua.
  #
  # rex-ui shows prompts and preview-less pickers in the Rex command palette,
  # through the ui_pick and ui_input actions in the Rex config's ui_bridge.lua.
  extraFiles."lua/rex-ui/init.lua".source = ./init.lua;
  extraConfigLua = ''
    require("rex-ui")
  '';

  # rex-ui sets vim.ui.select and vim.ui.input itself and falls back to
  # Neovim's own, so Snacks sets neither.
  plugins.snacks.settings = {
    input.enabled = false;
    picker.ui_select = false;
  };
}
