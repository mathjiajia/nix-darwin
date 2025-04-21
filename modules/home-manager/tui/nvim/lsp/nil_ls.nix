{pkgs, ...}: {
  programs.nixvim.lsp.servers.nil_ls = {
    enable = true;
    package = pkgs.nil;
    config = {
      cmd = ["${pkgs.nil}/bin/nil"];
      filetypes = ["nix"];
      root_markers = ["flake.nix" ".git"];
    };
  };
}
