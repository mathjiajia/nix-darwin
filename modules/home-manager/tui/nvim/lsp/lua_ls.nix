{ lib, pkgs, ... }:
{
  programs.nixvim.lsp.servers.lua_ls = {
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
        "selene.toml"
        "selene.yml"
        ".git"
      ];
      setttings.Lua = {
        # codeLens.enable = true;
        hint = {
          enable = true;
          semicolon = "Disable";
        };
        completion.callSnippet = "Replace";
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
