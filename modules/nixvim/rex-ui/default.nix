{
  # rex-ui shows prompts and preview-less pickers in the Rex command palette,
  # through the ui_pick and ui_input actions in the Rex config's ui_bridge.lua.
  extraFiles."lua/rex-ui/init.lua".source = ./init.lua;
  extraConfigLua = ''
    require("rex-ui")
  '';
}
