{pkgs, ...}: {
  programs.nixvim.lsp.servers.ruff = {
    enable = true;
    config = {
      cmd = ["${pkgs.ruff}/bin/ruff" "server"];
      filetypes = ["python"];
      root_markers = [
        "pyproject.toml"
        "ruff.toml"
        ".ruff.toml"
        ".git"
      ];
    };
  };
}
