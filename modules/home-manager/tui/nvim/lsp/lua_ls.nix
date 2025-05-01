{pkgs, ...}: {
  programs.nixvim.lsp.servers.lua_ls = {
    enable = true;
    settings = {
      cmd = ["${pkgs.lua-language-server}/bin/lua-language-server"];
      filetypes = ["lua"];
      root_markers = [
        ".luarc.json"
        ".luarc.jsonc"
        "tylua.toml"
        "stylua.toml"
        "selene.toml"
        "selene.yml"
        ".git"
      ];
      settting.Lua = {
        completion.callSnippet = "Replace";
        hint.enable = true;
        runtime.version = "LuaJIT";
        telemetry.enable = false;
        workspace = {
          checkThirdParty = false;
          library = ["vim.env.VIMRUNTIME"];
        };
      };
    };
  };
}
