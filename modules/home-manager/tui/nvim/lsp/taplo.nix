{pkgs, ...}: {
  programs.nixvim.extraConfigLua =
    # lua
    ''
      vim.lsp.config("taplo", {
      	cmd = { "${pkgs.taplo}/bin/taplo", "lsp", "stdio" },
      	filetypes = { "toml" },
      	root_markers = { ".git" },
      	single_file_support = true,
      })
    '';
}
