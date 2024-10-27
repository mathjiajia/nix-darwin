{
  programs.nixvim = {
    diagnostics = {
      virtual_text = {
        spacing = 4;
        prefix = "●";
      };
      severity_sort = true;
      signs.text.__raw =
        # lua
        ''
          {
          	[vim.diagnostic.severity.ERROR] = " ",
          	[vim.diagnostic.severity.WARN] = " ",
          	[vim.diagnostic.severity.INFO] = " ",
          	[vim.diagnostic.severity.HINT] = " ",
          }
        '';
    };

    keymaps = [
      {
        key = "<leader>qq";
        action.__raw =
          # lua
          ''function() vim.diagnostic.setqflist() end'';
        options.desc = "Set Quickfix";
      }

      {
        key = "<leader>ql";
        action.__raw =
          # lua
          ''function() vim.diagnostic.setloclist() end'';
        options.desc = "Set Loclist";
      }
    ];
  };
}
