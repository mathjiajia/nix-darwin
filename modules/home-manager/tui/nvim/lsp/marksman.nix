{pkgs, ...}: {
  programs.nixvim.lsp.servers.marksman = {
    enable = true;
    settings = {
      cmd = ["${pkgs.marksman}/bin/marksman" "server"];
      filetypes = ["markdown" "markdown.mdx"];
      root_markers = [".marksman.toml" ".git"];
      single_file_support = true;
    };
  };
}
