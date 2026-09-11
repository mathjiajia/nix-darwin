{
  imports = [
    ./clangd.nix
    # ./copilot.nix
    ./emmylua_ls.nix
    ./marksman.nix
    ./matlab_ls.nix
    ./nixd.nix
    ./pyrefly.nix
    # ./ruff.nix
    ./sourcekit.nix
    ./taplo.nix
    ./texlab.nix
  ];

  diagnostic.settings = {
    severity_sort = true;
    signs.text = {
      "__rawKey__vim.diagnostic.severity.ERROR" = "";
      "__rawKey__vim.diagnostic.severity.WARN" = "";
      "__rawKey__vim.diagnostic.severity.HINT" = "";
      "__rawKey__vim.diagnostic.severity.INFO" = "";
    };
    virtual_lines.current_line = true;
    virtual_text.current_line = false;
  };

  lsp = {
    codelens.enable = true;
    inlayHints.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "gd";
        lspBufAction = "definition";
        options.desc = "Go Definition";
      }
      {
        mode = "n";
        key = "gD";
        lspBufAction = "declaration";
        options.desc = "Go Declaration";
      }
      {
        mode = "n";
        key = "gt";
        lspBufAction = "type_definition";
        options.desc = "Go Type Definition";
      }
      {
        mode = "n";
        key = "<C-k>";
        lspBufAction = "signature_help";
        options.desc = "Signature Help";
      }
    ];
    onAttach =
      #lua
      ''
        if client:supports_method("textDocument/foldingRange", bufnr) then
        	local win = vim.api.nvim_get_current_win()
        	vim.wo[win][0].foldexpr = vim.lsp.foldexpr
        end
      '';
  };
}
