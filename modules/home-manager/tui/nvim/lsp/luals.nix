{pkgs, ...}: {
  programs.nixvim.extraFiles."lsp/luals.lua".text =
    # lua
    ''
      return {
      	cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
      	filetypes = { "lua" },
      	root_markers = {
      		".luarc.json",
      		".luarc.jsonc",
      		".luacheckrc",
      		".stylua.toml",
      		"stylua.toml",
      		"selene.toml",
      		"selene.yml",
      		".git",
      	},
      	settings = {
      		Lua = {
      			runtime = { version = "LuaJIT" },
      			workspace = {
      				checkThirdParty = false,
      				library = { vim.env.VIMRUNTIME },
      			},
      			completion = { callSnippet = "Replace" },
      			hint = { enable = true },
      			telemetry = { enable = false },
      		},
      	},
      }
    '';
}
