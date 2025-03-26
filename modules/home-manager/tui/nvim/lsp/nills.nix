{pkgs, ...}: {
  programs.nixvim.extraFiles = {
    "lsp/nills.lua".text =
      # lua
      ''
        return {
        	cmd = { "${pkgs.nil}/bin/nil" },
        	filetypes = { "nix" },
        	root_markers = { "flake.nix", ".git" },
        }
      '';
  };
}
