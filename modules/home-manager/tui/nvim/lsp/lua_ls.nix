{ pkgs, ... }:
{
  programs.nixvim.lsp.servers.lua_ls = {
    enable = true;
    config = {
      cmd = [ "${pkgs.lua-language-server}/bin/lua-language-server" ];
      filetypes = [ "lua" ];
      root_markers = [
        ".luarc.json"
        ".luarc.jsonc"
        ".luacheckrc"
        "tylua.toml"
        "stylua.toml"
        "selene.toml"
        "selene.yml"
        ".git"
      ];
      setttings.Lua = {
        completion.callSnippet = "Replace";
        hint.enable = true;
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
