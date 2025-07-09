{pkgs, ...}: {
  programs.nixvim.lsp.servers.copilot_ls = {
    enable = true;
    package = pkgs.copilot-language-server;
    settings = {
      name = "copilot_ls";
      cmd = ["${pkgs.copilot-language-server}/bin/copilot-language-server" "--stdio"];
      init_options = {
        editorInfo = {
          name = "neovim";
          version = "0.12.0";
        };
        editorPluginInfo = {
          name = "Github Copilot LSP for Neovim";
          version = "0.0.1";
        };
      };
      root_dir.__raw = ''vim.uv.cwd()'';
    };
  };
}
