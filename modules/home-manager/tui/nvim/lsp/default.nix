{
  imports = [
    ./basedpyright.nix
    ./copilot_ls.nix
    ./clangd.nix
    ./lua_ls.nix
    ./matlab_ls.nix
    ./nil_ls.nix
    ./sourcekit.nix
    ./taplo.nix
    ./texlab.nix
  ];

  programs.nixvim = {
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

    lsp.onAttach =
      #lua
      ''
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go Declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go Definition" })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go Type Definition" })

        if client:supports_method("textDocument/foldingRange", bufnr) then
        	local win = vim.api.nvim_get_current_win()
        	vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client:supports_method("textDocument/documentHighlight") then
        	local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", {})
        	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        		buffer = bufnr,
        		group = highlight_augroup,
        		callback = vim.lsp.buf.document_highlight,
        	})

        	vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        		buffer = bufnr,
        		group = highlight_augroup,
        		callback = vim.lsp.buf.clear_references,
        	})
        end

        if client:supports_method("textDocument/inlayHint", bufnr) then
        	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        	vim.keymap.set("n", "<M-i>", function()
        		vim.lsp.inlay_hint.enable(
        			not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
        			{ bufnr = bufnr }
        		)
        	end, { buffer = bufnr, desc = "Inlay Hint Toggle" })
        end
      '';
  };
}
