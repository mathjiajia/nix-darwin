{pkgs, ...}: {
  # programs.nixvim.keymaps = [
  #   {
  #     key = "<Tab>";
  #     action.__raw = ''
  #       function()
  #       	local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
  #       	  or (
  #       	    require("copilot-lsp.nes").apply_pending_nes()
  #       	    and require("copilot-lsp.nes").walk_cursor_end_edit()
  #           )
  #       end
  #     '';
  #     options.desc = "Next Edit Suggestion";
  #   }
  # ];

  programs.nixvim.lsp.servers.copilot_ls = {
    enable = true;
    package = pkgs.copilot-language-server;
    config.cmd = ["${pkgs.copilot-language-server}/bin/copilot-language-server" "--stdio"];
  };
}
