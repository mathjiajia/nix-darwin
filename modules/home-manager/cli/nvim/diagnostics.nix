{
  programs.nixvim = {
    diagnostics = {
      virtual_text = {
        spacing = 4;
        prefix = "●";
      };
      severity_sort = true;
      signs.text = {
        "__rawKey__vim.diagnostic.severity.ERROR" = "";
        "__rawKey__vim.diagnostic.severity.WARN" = "";
        "__rawKey__vim.diagnostic.severity.HINT" = "";
        "__rawKey__vim.diagnostic.severity.INFO" = "";
      };
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
