{
  programs.nixvim.lsp.servers.clangd = {
    enable = true;
    package = null;
    settings = {
      cmd = ["/usr/bin/clangd"];
      filetypes = ["c" "cpp"];
      root_markers = [
        ".clangd"
        ".clang-tidy"
        ".clang-format"
        "compile_commands.json"
        "compile_flags.txt"
        "configure.ac" # AutoTool
        ".git"
      ];
      capabilities = {
        textDocument.completion.editsNearCursor = true;
        offsetEncoding = ["utf-8" "utf-16"];
      };
      on_init.__raw = ''
        function(client, init_result)
        	if init_result.offsetEncoding then
        		client.offset_encoding = init_result.offsetEncoding
        	end
        end
      '';
      on_attach.__raw = ''
        function(client, bufnr)
        	local win = vim.api.nvim_get_current_win()
        	local params = vim.lsp.util.make_position_params(win, client.offset_encoding)

        	-- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
        	local function switch_source_header()
        		local method_name = "textDocument/switchSourceHeader"
        		client:request(method_name, params, function(err, result)
        			if err then
        				error(tostring(err))
        			end
        			if not result then
        				vim.notify("corresponding file cannot be determined")
        				return
        			end
        			vim.cmd.edit(vim.uri_to_fname(result))
        		end, bufnr)
        	end

        	local function symbol_info()
        		client:request("textDocument/symbolInfo", params, function(err, res)
        			if err or #res == 0 then
        				-- Clangd always returns an error, there is not reason to parse it
        				return
        			end
        			local container = string.format("container: %s", res[1].containerName) ---@type string
        			local name = string.format("name: %s", res[1].name) ---@type string
        			vim.lsp.util.open_floating_preview({ name, container }, "", {
        				height = 2,
        				width = math.max(string.len(name), string.len(container)),
        				focusable = false,
        				focus = false,
        				title = "Symbol Info",
        			})
        		end, bufnr)
        	end

        	vim.api.nvim_buf_create_user_command(
        		bufnr,
        		"LspClangdSwitchSourceHeader",
        		switch_source_header,
        		{ desc = "Switch between source/header" }
        	)
        	vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSymbolInfo", symbol_info, { desc = "Show symbol info" })
        end
      '';
    };
  };
}
