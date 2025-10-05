{pkgs, ...}: {
  programs.nixvim.lsp.servers.copilot = {
    enable = true;
    config = {
      cmd = ["${pkgs.copilot-language-server}/bin/copilot-language-server" "--stdio"];
      root_markers = [".git"];
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
