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
    diagnostic.config = {
      severity_sort = true;
      signs.text = {
        "__rawKey__vim.diagnostic.severity.ERROR" = "";
        "__rawKey__vim.diagnostic.severity.WARN" = "";
        "__rawKey__vim.diagnostic.severity.HINT" = "";
        "__rawKey__vim.diagnostic.severity.INFO" = "";
      };
      virtual_lines.current_line = true;
    };

    autoGroups.UserLspConfig = {};
    autoCmd = [
      {
        event = "LspAttach";
        group = "UserLspConfig";
        callback.__raw =
          # lua
          ''
            function(args)
            	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

            	local keymaps = {
            		{ "gD", vim.lsp.buf.declaration, method = "textDocument/declaration" },
            		{ "gd", vim.lsp.buf.definition, method = "textDocument/definition" },
            		{ "<C-k>", vim.lsp.buf.signature_help, method = "textDocument/signatureHelp" },
            		{ "gt", vim.lsp.buf.type_definition, method = "textDocument/typeDefinition" },
            	}

            	for _, keys in ipairs(keymaps) do
            		if client:supports_method(keys.method, args.buf) then
            			vim.keymap.set("n", keys[1], keys[2], { buffer = args.buf, desc = keys.method })
            		end
            	end

            	if client:supports_method("textDocument/foldingRange", args.buf) then
            		local win = vim.api.nvim_get_current_win()
            		vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
            	end

            	if client:supports_method("textDocument/documentColor", args.buf) then
            		vim.lsp.document_color.enable(true, args.buf)
            	end

            	if client:supports_method("textDocument/inlayHint", args.buf) then
            		vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            		vim.keymap.set("n", "<M-i>", function()
            			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
            		end, { buffer = args.buf, desc = "Inlay Hint Toggle" })
            	end
            end
          '';
      }
    ];
  };
}
