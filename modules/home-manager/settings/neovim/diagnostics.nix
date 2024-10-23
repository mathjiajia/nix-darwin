{ ... }:
{
  programs.nixvim.diagnostics = {
    virtual_text = {
      spacing = 4;
      prefix = "●";
    };
    severity_sort = true;
    signs.text.__raw = # lua
      ''
        {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = " ",
        }
      '';
  };
}
