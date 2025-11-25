{ lib, pkgs, ... }:
{
  lsp.servers.lua_ls = {
    enable = true;
    config = {
      cmd = [ "${lib.getExe pkgs.lua-language-server}" ];
      filetypes = [ "lua" ];
      root_markers = [
        ".luarc.json"
        ".luarc.jsonc"
        ".luacheckrc"
        ".stylua.toml"
        "stylua.toml"
        ".git"
      ];
      setttings.Lua = {
        # codeLens.enable = true;
        completion.callSnippet = "Replace";
        format.enable = false;
        hint = {
          enable = true;
          semicolon = "Disable";
        };
        runtime = {
          version = "LuaJIT";
          path = [
            "lua/?.lua"
            "lua/?/init.lua"
          ];
        };
        telemetry.enable = false;
        workspace = {
          checkThirdParty = false;
          library.__unkeyed-1.__raw = "vim.env.VIMRUNTIME";
        };
      };
    };
  };
}
