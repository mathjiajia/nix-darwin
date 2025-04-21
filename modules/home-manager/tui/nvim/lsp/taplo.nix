{pkgs, ...}: {
  programs.nixvim.lsp.servers.taple = {
    enable = true;
    package = pkgs.taplo;
    config = {
      cmd = ["${pkgs.taplo}/bin/taplo" "lsp" "stdio"];
      filetypes = ["toml"];
      root_markers = [".git"];
    };
  };
}
