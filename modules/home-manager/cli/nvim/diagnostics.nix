{
  programs.nixvim = {
    diagnostics = {
      float.border = "rounded";
      severity_sort = true;
      signs.text = {
        "__rawKey__vim.diagnostic.severity.ERROR" = "";
        "__rawKey__vim.diagnostic.severity.WARN" = "";
        "__rawKey__vim.diagnostic.severity.HINT" = "";
        "__rawKey__vim.diagnostic.severity.INFO" = "";
      };
      virtual_lines.current_line = true;
      # virtual_text = {
      #   spacing = 2;
      #   prefix = "●";
      # };
    };

    keymaps = [
      {
        key = "<leader>qq";
        action.__raw = ''function() vim.diagnostic.setqflist() end'';
        options.desc = "Set Quickfix";
      }

      {
        key = "<leader>ql";
        action.__raw = ''function() vim.diagnostic.setloclist() end'';
        options.desc = "Set Loclist";
      }
    ];
  };
}
