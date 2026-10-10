{
  config,
  lib,
  pkgs,
  ...
}:
{
  lsp.servers.emmylua_ls = {
    enable = true;
    config = {
      cmd = [ "${lib.getExe pkgs.emmylua-ls}" ];
      filetypes = [ "lua" ];
      root_markers = [
        [
          ".emmyrc.json"
          ".emmyrc.lua"
          ".luarc.json"
          ".luarc.jsonc"
        ]
        [
          ".luacheckrc"
          ".stylua.toml"
          "stylua.toml"
          "selene.toml"
          "selene.yml"
        ]
        [ ".git" ]
      ];
      workspace_required = false;
      settings.emmylua = {
        runtime.version = "LuaJIT";
        diagnostics.globals = [ "vim" ];
        workspace.library = [ "${config.package}/share/nvim/runtime/lua" ];
        codeLens.enable = true;
        hint.enable = true;
      };
    };
  };
}
