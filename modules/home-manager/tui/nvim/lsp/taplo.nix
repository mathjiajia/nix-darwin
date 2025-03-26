{pkgs, ...}: {
  programs.nixvim.extraFiles."lsp/taplo.lua".text =
    # lua
    ''
      return {
      	cmd = { "${pkgs.taplo}/bin/taplo", "lsp", "stdio" },
      	filetypes = { "toml" },
      	root_markers = { ".git" },
      }
    '';
}
