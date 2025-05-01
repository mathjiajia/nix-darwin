{pkgs, ...}: {
  programs.nixvim.lsp.servers.nil_ls = {
    enable = true;
    settings = {
      cmd = ["${pkgs.nil}/bin/nil"];
      filetypes = ["nix"];
      root_markers = ["flake.nix" ".git"];
    };
  };
}
