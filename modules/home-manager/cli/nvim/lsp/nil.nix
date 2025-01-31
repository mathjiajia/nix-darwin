{pkgs, ...}: {
  programs.nixvim.extraConfigLua =
    # lua
    ''
      vim.lsp.config("nills", {
      	cmd = { "${pkgs.nil}/bin/nil" },
      	filetypes = { "nix" },
      	single_file_support = true,
      	root_markers = { "flake.nix", ".git" },
      })
    '';
}
