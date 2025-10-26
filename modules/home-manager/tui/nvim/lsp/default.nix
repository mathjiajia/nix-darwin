{
  imports = [
    ./clangd.nix
    ./copilot.nix
    ./leanls.nix
    ./lua_ls.nix
    ./marksman.nix
    ./matlab_ls.nix
    ./nixd.nix
    ./pyrefly.nix
    # ./ruff.nix
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
        		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        	end, { buffer = bufnr, desc = "Inlay Hint Toggle" })
        end
        if client:supports_method("textDocument/documentSymbol") then
        	local folder_icon = "%#Conditional#" .. "󰉋" .. "%#Normal#"
        	local file_icon = "󰈙"

        	local kind_icons = {
        		[1] = "%#File#" .. "󰈙" .. "%#Normal#", -- file
        		[2] = "%#Module#" .. "󰠱" .. "%#Normal#", -- module
        		[3] = "%#Structure#" .. "" .. "%#Normal#", -- namespace
        		[19] = "%#Keyword#" .. "󰌋" .. "%#Normal#", -- key
        		[5] = "%#Class#" .. "" .. "%#Normal#", -- class
        		[6] = "%#Method#" .. "󰆧" .. "%#Normal#", -- method
        		[7] = "%#Property#" .. "" .. "%#Normal#", -- property
        		[8] = "%#Field#" .. "" .. "%#Normal#", -- field
        		[9] = "%#Function#" .. "" .. "%#Normal#", -- constructor
        		[10] = "%#Enum#" .. "" .. "%#Normal#", -- enum
        		[11] = "%#Type#" .. "" .. "%#Normal#", -- interface
        		[12] = "%#Function#" .. "󰊕" .. "%#Normal#", -- function
        		[13] = "%#None#" .. "󰂡" .. "%#Normal#", -- variable
        		[14] = "%#Constant#" .. "󰏿" .. "%#Normal#", -- constant
        		[15] = "%#String#" .. "" .. "%#Normal#", -- string
        		[16] = "%#Number#" .. "" .. "%#Normal#", -- number
        		[17] = "%#Boolean#" .. "" .. "%#Normal#", -- boolean
        		[18] = "%#Array#" .. "" .. "%#Normal#", -- array
        		[20] = "%#Class#" .. "" .. "%#Normal#", -- object
        		[4] = "", -- package
        		[21] = "󰟢", -- null
        		[22] = "", -- enum-member
        		[23] = "%#Struct#" .. "" .. "%#Normal#", -- struct
        		[24] = "", -- event
        		[25] = "", -- operator
        		[26] = "󰅲", -- type-parameter
        	}

        	local function range_contains_pos(range, line, char)
        		local start = range.start
        		local stop = range["end"]

        		if line < start.line or line > stop.line then
        			return false
        		end

        		if line == start.line and char < start.character then
        			return false
        		end

        		if line == stop.line and char > stop.character then
        			return false
        		end

        		return true
        	end

        	local function find_symbol_path(symbol_list, line, char, path)
        		if not symbol_list or #symbol_list == 0 then
        			return false
        		end

        		for _, symbol in ipairs(symbol_list) do
        			if range_contains_pos(symbol.range, line, char) then
        				local icon = kind_icons[symbol.kind] or ""
        				table.insert(path, icon .. " " .. symbol.name)
        				find_symbol_path(symbol.children, line, char, path)
        				return true
        			end
        		end
        		return false
        	end

        	local function lsp_callback(err, symbols, ctx, config)
        		if err or not symbols then
        			vim.o.winbar = ""
        			return
        		end

        		local winnr = vim.api.nvim_get_current_win()
        		local pos = vim.api.nvim_win_get_cursor(0)
        		local cursor_line = pos[1] - 1
        		local cursor_char = pos[2]

        		local file_path = vim.fn.bufname(ctx.bufnr)
        		if not file_path or file_path == "" then
        			vim.o.winbar = "[No Name]"
        			return
        		end

        		local root_dir = client.root_dir or vim.fn.getcwd(winnr)
        		local relative_path = vim.fs.relpath(root_dir, file_path)

        		local breadcrumbs = {}

        		local path_components = vim.split(relative_path, "/", { trimempty = true })
        		local num_components = #path_components

        		for i, component in ipairs(path_components) do
        			if i == num_components then
        				local icon
        				local icon_hl

        				if _G.MiniIcons then
        					icon, icon_hl = MiniIcons.get("file", component)
        				end
        				table.insert(
        					breadcrumbs,
        					"%#" .. icon_hl .. "#" .. (icon or file_icon) .. "%#Normal#" .. " " .. component
        				)
        			else
        				table.insert(breadcrumbs, folder_icon .. " " .. component)
        			end
        		end
        		find_symbol_path(symbols, cursor_line, cursor_char, breadcrumbs)

        		local breadcrumb_string = table.concat(breadcrumbs, " > ")

        		if breadcrumb_string ~= "" then
        			vim.api.nvim_set_option_value("winbar", " " .. breadcrumb_string, { win = winnr })
        		else
        			vim.api.nvim_set_option_value("winbar", " ", { win = winnr })
        		end
        	end

        	local function breadcrumbs_set()
        		local uri = vim.lsp.util.make_text_document_params(bufnr)["uri"]
        		if not uri then
        			vim.print("Error: Could not get URI for buffer. Is it saved?")
        			return
        		end

        		local params = { textDocument = { uri = uri } }

        		local buf_src = uri:sub(1, uri:find(":") - 1)
        		if buf_src ~= "file" then
        			vim.o.winbar = ""
        			return
        		end

        		local result, _ = pcall(vim.lsp.buf_request, bufnr, "textDocument/documentSymbol", params, lsp_callback)

        		if not result then
        			return
        		end
        	end

        	local breadcrumbs_augroup = vim.api.nvim_create_augroup("Breadcrumbs", { clear = true })

        	vim.api.nvim_create_autocmd({ "CursorMoved" }, {
        		group = breadcrumbs_augroup,
        		callback = breadcrumbs_set,
        		desc = "Set breadcrumbs.",
        	})

        	vim.api.nvim_create_autocmd({ "WinLeave" }, {
        		group = breadcrumbs_augroup,
        		callback = function()
        			vim.o.winbar = ""
        		end,
        		desc = "Clear breadcrumbs when leaving window.",
        	})
        end
      '';
  };
}
