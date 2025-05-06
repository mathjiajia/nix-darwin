{pkgs, ...}: {
  programs.nixvim.lsp.servers.taple = {
    enable = true;
    settings = {
      cmd = ["${pkgs.taplo}/bin/taplo" "lsp" "stdio"];
      filetypes = ["toml"];
      root_markers = [".taplo.toml" "taplo.toml" ".git"];
    };
  };
}
