{pkgs, ...}: {
  programs.nixvim.lsp.servers.ruff = {
    enable = true;
    settings = {
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
