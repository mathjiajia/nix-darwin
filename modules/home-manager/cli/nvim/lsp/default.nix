{pkgs, ...}: {
  imports = [
    ./basedpyright.nix
    ./clangd.nix
    ./luals.nix
    ./matlabls.nix
    ./nil.nix
    ./sourcekit.nix
    ./taplo.nix
    ./texlab.nix
  ];

  programs.nixvim = {
    extraPackages = with pkgs; [
      basedpyright
      clang-tools
      lua-language-server
      matlab-language-server
      nil
      taplo
      texlab
    ];

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

    extraConfigLua =
      # lua
      ''
        vim.lsp.enable({ "basedpyright", "clangd", "luals", "matlabls", "nills", "sourcekit", "taplo", "texlab" })
      '';

    autoGroups.UserLspConfig = {};
    autoCmd = [
      {
        event = "LspAttach";
        group = "UserLspConfig";
        callback.__raw =
          # lua
          ''
            function(ev)
            	local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
            	local methods = vim.lsp.protocol.Methods

            	local keymaps = {
            		{ "gD", vim.lsp.buf.declaration, method = methods.textDocument_declaration },
            		{ "gd", vim.lsp.buf.definition, method = methods.textDocument_definition },
            		{ "gi", vim.lsp.buf.implementation, method = methods.textDocument_implementation },
            		{ "<C-k>", vim.lsp.buf.signature_help, method = methods.textDocument_signatureHelp },
            		{ "gt", vim.lsp.buf.type_definition, method = methods.textDocument_typeDefinition },
            	}

            	for _, keys in ipairs(keymaps) do
            		if client:supports_method(keys.method, ev.buf) then
            			vim.keymap.set(keys.mode or "n", keys[1], keys[2], { buffer = ev.buf, desc = keys.method })
            		end
            	end

            	if client:supports_method(methods.textDocument_inlayHint, ev.buf) then
            		vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            		vim.keymap.set("n", "<M-i>", function()
            			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            		end, { desc = "Inlay Hint Toggle", buffer = ev.buf })
            	end
            end
          '';
      }
    ];
  };
}
