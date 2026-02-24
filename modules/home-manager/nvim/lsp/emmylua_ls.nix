{ lib, pkgs, ... }:
{
  lsp.servers.emmylua_ls = {
    enable = true;
    config = {
      cmd = [ "${lib.getExe pkgs.emmylua-ls}" ];
      filetypes = [ "lua" ];
      root_markers = [
        ".luarc.json"
        ".emmyrc.json"
        ".luacheckrc"
        ".git"
      ];
      workspace_required = false;
    };
  };
}
