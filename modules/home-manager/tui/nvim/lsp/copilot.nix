{ lib, pkgs, ... }:
{
  programs.nixvim.lsp.servers.copilot = {
    enable = true;
    config = {
      cmd = [
        "${lib.getExe pkgs.copilot-language-server}"
        "--stdio"
      ];
      root_markers = [ ".git" ];
      init_options = {
        editorInfo = {
          name = "Neovim";
          version.__raw = ''tostring(vim.version())'';
        };
        editorPluginInfo = {
          name = "Neovim";
          version.__raw = ''tostring(vim.version())'';
        };
      };
      settings.telemetry.telemetryLevel = "off";
    };
  };
}
