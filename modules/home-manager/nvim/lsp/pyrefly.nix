{ lib, pkgs, ... }:
{
  lsp.servers.pyrefly = {
    enable = true;
    config = {
      cmd = [
        "${lib.getExe pkgs.pyrefly}"
        "lsp"
      ];
      filetypes = [ "python" ];
      root_markers = [
        "pyrefly.toml"
        "pyproject.toml"
        "setup.py"
        "setup.cfg"
        "requirements.txt"
        "Pipfile"
        ".git"
      ];
      on_exit.__ray =
        #lua
        ''
          function(code, _, _)
          	vim.notify('Closing Pyrefly LSP exited with code: ' .. code, vim.log.levels.INFO)
          end
        '';
    };
  };
}
