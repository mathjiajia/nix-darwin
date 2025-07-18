{
  inputs,
  pkgs,
  ...
}: let
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    name = "math-snippets";
    src = inputs.nvim-math-snippets;
    nvimSkipModules = [
      "math-snippets.position"
      "math-snippets.context"
      "math-snippets.latex"
    ];
  };
  math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "math-conceal";
    src = inputs.math-conceal-nvim;
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    blink-pairs
    heirline-nvim

    math-conceal-nvim
    nvim-math-snippets
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("vim._extui").enable({})
      require("math-conceal").setup()
      require("blink.pairs").setup({
      	mappings = {
      		pairs = {
      			["'"] = {
      				{
      					"\'\'\'",
      					"\'\'\'",
      					when = function()
      						local cursor = vim.api.nvim_win_get_cursor(0)
      						local line = vim.api.nvim_get_current_line()
      						return line:sub(cursor[2] - 1, cursor[2]) == "\'\'"
      					end,
      					filetypes = { "python" },
      				},
      				{
      					"'",
      					enter = false,
      					space = false,
      					when = function()
      						local cursor = vim.api.nvim_win_get_cursor(0)
      						local char = vim.api.nvim_get_current_line():sub(cursor[2], cursor[2])
      						return not char:match("%w")
      							and (vim.bo.filetype ~= "rust" or char:match("[&<]"))
      							and not vim.list_contains({ "bib", "tex", "plaintex" }, vim.bo.filetype)
      					end,
      				},
      			},
      			["`"] = {
      				{
      					"```",
      					"```",
      					when = function()
      						local cursor = vim.api.nvim_win_get_cursor(0)
      						local line = vim.api.nvim_get_current_line()
      						return line:sub(cursor[2] - 1, cursor[2]) == "``"
      					end,
      					filetypes = { "markdown", "vimwiki", "rmarkdown", "rmd", "pandoc", "quarto", "typst" },
      				},
      				{ "`", "'", filetypes = { "bib", "latex", "tex" } },
      				{ "`", enter = false, space = false },
      			},
      		},
      	},
      	highlights = {
      		groups = {
      			"BlinkPairsBlue",
      			"BlinkPairsYellow",
      			"BlinkPairsGreen",
      			"BlinkPairsTeal",
      			"BlinkPairsMagenta",
      			"BlinkPairsPurple",
      			"BlinkPairsOrange",
      		},
      	},
      })

      local function fold_virt_text(result, start_text, lnum)
      	local text = ""
      	local hl
      	for i = 1, #start_text do
      		local char = start_text:sub(i, i)
      		local captured_highlights = vim.treesitter.get_captures_at_pos(0, lnum, i - 1)
      		local outmost_highlight = captured_highlights[#captured_highlights]
      		if outmost_highlight then
      			local new_hl = "@" .. outmost_highlight.capture
      			if new_hl ~= hl then
      				table.insert(result, { text, hl })
      				text = ""
      				hl = nil
      			end
      			text = text .. char
      			hl = new_hl
      		else
      			text = text .. char
      		end
      	end
      	table.insert(result, { text, hl })
      end
      function _G.custom_foldtext()
      	local start_text = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
      	local nline = vim.v.foldend - vim.v.foldstart
      	local result = {}
      	fold_virt_text(result, start_text, vim.v.foldstart - 1)
      	table.insert(result, { "    ", nil })
      	table.insert(result, { " ↙ " .. nline .. " lines ", "Search" })
      	return result
      end

      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local colors = {
      	bright_bg = utils.get_highlight("Folded").bg,
      	bright_fg = utils.get_highlight("Folded").fg,
      	red = utils.get_highlight("DiagnosticError").fg,
      	dark_red = utils.get_highlight("DiffDelete").bg,
      	green = utils.get_highlight("String").fg,
      	blue = utils.get_highlight("Function").fg,
      	gray = utils.get_highlight("NonText").fg,
      	orange = utils.get_highlight("Constant").fg,
      	purple = utils.get_highlight("Statement").fg,
      	cyan = utils.get_highlight("Special").fg,
      	diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      	diag_error = utils.get_highlight("DiagnosticError").fg,
      	diag_hint = utils.get_highlight("DiagnosticHint").fg,
      	diag_info = utils.get_highlight("DiagnosticInfo").fg,
      	git_del = utils.get_highlight("GitSignsDelete").fg,
      	git_add = utils.get_highlight("GitSignsAdd").fg,
      	git_change = utils.get_highlight("GitSignsChange").fg,
      }

      local VimMode = {
      	init = function(self)
      		self.mode = vim.fn.mode(1)
      		self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
      	end,
      	update = {
      		"ModeChanged",
      		pattern = "*:*",
      		callback = vim.schedule_wrap(function()
      			vim.cmd.redrawstatus()
      		end),
      	},
      	static = {
      		mode_names = {
      			n = "NORMAL",
      			no = "NORMAL",
      			nov = "NORMAL",
      			noV = "NORMAL",
      			["no\22"] = "NORMAL",
      			niI = "NORMAL",
      			niR = "NORMAL",
      			niV = "NORMAL",
      			nt = "NORMAL",
      			v = "VISUAL",
      			vs = "VISUAL",
      			V = "VISUAL",
      			Vs = "VISUAL",
      			["\22"] = "VISUAL",
      			["\22s"] = "VISUAL",
      			s = "SELECT",
      			S = "SELECT",
      			["\19"] = "SELECT",
      			i = "INSERT",
      			ic = "INSERT",
      			ix = "INSERT",
      			R = "REPLACE",
      			Rc = "REPLACE",
      			Rx = "REPLACE",
      			Rv = "REPLACE",
      			Rvc = "REPLACE",
      			Rvx = "REPLACE",
      			c = "COMMAND",
      			cv = "Ex",
      			r = "...",
      			rm = "M",
      			["r?"] = "?",
      			["!"] = "!",
      			t = "TERM ",
      		},
      		mode_colors = {
      			n = "purple",
      			i = "green",
      			v = "orange",
      			V = "orange",
      			["\22"] = "orange",
      			c = "orange",
      			s = "yellow",
      			S = "yellow",
      			["\19"] = "yellow",
      			r = "green",
      			R = "green",
      			["!"] = "red",
      			t = "red",
      		},
      	},
      	{
      		provider = function(self)
      			return "  %2(" .. self.mode_names[self.mode] .. "%)"
      		end,
      		hl = function(self)
      			return { fg = "bg", bg = self.mode_color }
      		end,
      	},
      	{
      		provider = "",
      		hl = function(self)
      			return { fg = self.mode_color }
      		end,
      	},
      }

      local FileIcon = {
      	init = function(self)
      		local filename = self.filename
      		self.icon, self.icon_hl = require("mini.icons").get("file", filename)
      	end,
      	provider = function(self)
      		return self.icon and (self.icon .. " ")
      	end,
      	hl = function(self)
      		return self.icon_hl
      	end,
      }

      local FileName = {
      	provider = function(self)
      		local filename = vim.fn.fnamemodify(self.filename, ":.")
      		if filename == "" then
      			return "[No Name]"
      		end
      		if not conditions.width_percent_below(#filename, 0.25) then
      			filename = vim.fn.pathshorten(filename)
      		end
      		return filename
      	end,
      	hl = { fg = utils.get_highlight("Directory").fg },
      }

      local WorkDir = {
      	provider = function()
      		local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. "  "
      		local cwd = vim.fn.getcwd(0)
      		cwd = vim.fn.fnamemodify(cwd, ":~")
      		cwd = vim.fn.pathshorten(vim.fn.fnamemodify(cwd, ":~"))
      		local trail = cwd:sub(-1) == "/" and "" or "/"
      		return icon .. cwd .. trail
      	end,
      	hl = { fg = "blue" },
      }

      local Git = {
      	condition = conditions.is_git_repo,
      	init = function(self)
      		self.status_dict = vim.b.gitsigns_status_dict
      		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      	end,
      	hl = { fg = "orange" },
      	{
      		provider = function(self)
      			return "  " .. self.status_dict.head
      		end,
      	},
      	{
      		provider = function(self)
      			local count = self.status_dict.added or 0
      			return count > 0 and ("  " .. count)
      		end,
      		hl = { fg = "git_add" },
      	},
      	{
      		provider = function(self)
      			local count = self.status_dict.removed or 0
      			return count > 0 and ("  " .. count)
      		end,
      		hl = { fg = "git_del" },
      	},
      	{
      		provider = function(self)
      			local count = self.status_dict.changed or 0
      			return count > 0 and ("  " .. count)
      		end,
      		hl = { fg = "git_change" },
      	},
      }

      local Diagnostics = {
      	condition = conditions.has_diagnostics,
      	static = { Error = " ", Warn = " ", Hint = " ", Info = " " },
      	init = function(self)
      		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      	end,
      	update = { "DiagnosticChanged", "BufEnter" },
      	{ provider = "![" },
      	{
      		provider = function(self)
      			return self.errors > 0 and (self.Error .. self.errors .. " ")
      		end,
      		hl = { fg = "diag_error" },
      	},
      	{
      		provider = function(self)
      			return self.warnings > 0 and (self.Warn .. self.warnings .. " ")
      		end,
      		hl = { fg = "diag_warn" },
      	},
      	{
      		provider = function(self)
      			return self.info > 0 and (self.Info .. self.info .. " ")
      		end,
      		hl = { fg = "diag_info" },
      	},
      	{
      		provider = function(self)
      			return self.hints > 0 and (self.Hint .. self.hints)
      		end,
      		hl = { fg = "diag_hint" },
      	},
      	{ provider = "]" },
      }

      local LSPActive = {
      	condition = conditions.lsp_attached,
      	update = { "LspAttach", "LspDetach" },
      	provider = function()
      		local names = {}
      		for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      			table.insert(names, server.name)
      		end
      		return "[" .. table.concat(names, ",") .. "]"
      	end,
      	hl = { fg = "green" },
      }

      local Ruler = {
      	{ provider = "", hl = { fg = "gray" } },
      	{ provider = " %7(%l/%3L%):%2c ", hl = { bg = "gray" } },
      }

      local FileType = {
      	provider = function()
      		return string.upper(vim.bo.filetype)
      	end,
      	hl = { fg = "yellow", bold = true },
      }

      local SearchCount = {
      	condition = function()
      		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
      	end,
      	init = function(self)
      		local ok, search = pcall(vim.fn.searchcount)
      		if ok and search.total then
      			self.search = search
      		end
      	end,
      	provider = function(self)
      		local search = self.search
      		return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
      	end,
      }

      local MacroRec = {
      	condition = function()
      		return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
      	end,
      	provider = " ",
      	hl = { fg = "orange", bold = true },
      	utils.surround({ "[", "]" }, nil, {
      		provider = function()
      			return vim.fn.reg_recording()
      		end,
      		hl = { fg = "green", bold = true },
      	}),
      	update = {
      		"RecordingEnter",
      		"RecordingLeave",
      	},
      }

      local TerminalName = {
      	provider = function()
      		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      		return " " .. tname
      	end,
      	hl = { fg = "blue" },
      }

      local HelpFileName = {
      	condition = function()
      		return vim.bo.filetype == "help"
      	end,
      	provider = function()
      		local filename = vim.api.nvim_buf_get_name(0)
      		return vim.fn.fnamemodify(filename, ":t")
      	end,
      	hl = { fg = colors.blue },
      }

      local Align = { provider = "%=" }

      local Space = { provider = " " }

      local DefaultStatusline = {
      	VimMode,
      	Space,
      	WorkDir,
      	Git,
      	Align,
      	SearchCount,
      	MacroRec,
      	Align,
      	Diagnostics,
      	LSPActive,
      	Space,
      	Ruler,
      	-- Space,
      	-- ScrollBar,
      	-- Space,
      	-- Spell,
      }

      local InactiveStatusline = {
      	condition = conditions.is_not_active,
      	Space,
      	FileType,
      	Space,
      	FileName,
      	Align,
      }

      local SpecialStatusline = {
      	condition = function()
      		return conditions.buffer_matches({
      			buftype = { "nofile", "prompt", "help", "quickfix", "snacks_input" },
      			filetype = { "^git.*", "fugitive" },
      		})
      	end,
      	Space,
      	FileType,
      	Space,
      	HelpFileName,
      	Align,
      }

      local TerminalStatusline = {
      	condition = function()
      		return conditions.buffer_matches({ buftype = { "terminal" } })
      	end,
      	hl = { bg = "dark_red" },
      	{ condition = conditions.is_active, VimMode, Space },
      	FileType,
      	Space,
      	TerminalName,
      	Align,
      }

      local StatusLine = {
      	fallthrough = false,
      	SpecialStatusline,
      	TerminalStatusline,
      	InactiveStatusline,
      	DefaultStatusline,
      	hl = "StatusLine",
      }

      -- Tabline
      local TablineBufnr = {
      	provider = function(self)
      		return tostring(self.bufnr) .. ". "
      	end,
      	hl = "Comment",
      }

      local TablineFileName = {
      	provider = function(self)
      		local filename = self.filename
      		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
      		return filename
      	end,
      	hl = function(self)
      		return { bold = self.is_active or self.is_visible, italic = true }
      	end,
      }

      local TablineFileFlags = {
      	{
      		condition = function(self)
      			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
      		end,
      		provider = " ● ", --[+]",
      		hl = { fg = "green" },
      	},
      	{
      		condition = function(self)
      			return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
      				or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
      		end,
      		provider = function(self)
      			if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
      				return "  "
      			else
      				return ""
      			end
      		end,
      		hl = { fg = "orange" },
      	},
      }

      local TablineFileNameBlock = {
      	init = function(self)
      		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      	end,
      	hl = function(self)
      		if self.is_active then
      			return "TabLineSel"
      		elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      			return { fg = "gray" }
      		else
      			return "TabLine"
      		end
      	end,
      	on_click = {
      		callback = function(_, minwid, _, button)
      			if button == "m" then
      				vim.schedule(function()
      					Snacks.bufdelete({ buf = minwid })
      				end)
      			else
      				vim.api.nvim_win_set_buf(0, minwid)
      			end
      		end,
      		minwid = function(self)
      			return self.bufnr
      		end,
      		name = "heirline_tabline_buffer_callback",
      	},
      	TablineBufnr,
      	FileIcon,
      	TablineFileName,
      	TablineFileFlags,
      }

      local TablineCloseButton = {
      	condition = function(self)
      		return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
      	end,
      	{ provider = " " },
      	{
      		provider = "✗",
      		hl = { fg = "gray" },
      		on_click = {
      			callback = function(_, minwid)
      				vim.schedule(function()
      					Snacks.bufdelete({ buf = minwid })
      					vim.cmd.redrawtabline()
      				end)
      			end,
      			minwid = function(self)
      				return self.bufnr
      			end,
      			name = "heirline_tabline_close_buffer_callback",
      		},
      	},
      }

      local TablineBufferBlock = utils.surround({ "█", "█" }, function(self)
      	if self.is_active then
      		return utils.get_highlight("TabLineSel").bg
      	else
      		return utils.get_highlight("TabLine").bg
      	end
      end, { TablineFileNameBlock, TablineCloseButton })

      local get_bufs = function()
      	return vim.tbl_filter(function(bufnr)
      		return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
      	end, vim.api.nvim_list_bufs())
      end

      local buflist_cache = {}

      vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
      	callback = function()
      		vim.schedule(function()
      			local buffers = get_bufs()
      			for i, v in ipairs(buffers) do
      				buflist_cache[i] = v
      			end
      			for i = #buffers + 1, #buflist_cache do
      				buflist_cache[i] = nil
      			end
      			if #buflist_cache > 1 then
      				vim.o.showtabline = 2
      			elseif vim.o.showtabline ~= 1 then
      				vim.o.showtabline = 1
      			end
      		end)
      	end,
      })

      local BufferLine = utils.make_buflist(
      	TablineBufferBlock,
      	{ provider = " ", hl = { fg = "gray" } },
      	{ provider = " ", hl = { fg = "gray" } },
      	function()
      		return buflist_cache
      	end,
      	false
      )

      local Tabpage = {
      	provider = function(self)
      		return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
      	end,
      	hl = function(self)
      		if not self.is_active then
      			return "TabLine"
      		else
      			return "TabLineSel"
      		end
      	end,
      }

      local TabpageClose = { provider = " %999X %X", hl = "TabLine" }

      local TabPages = {
      	condition = function()
      		return #vim.api.nvim_list_tabpages() >= 2
      	end,
      	{ provider = "%=" },
      	utils.make_tablist(Tabpage),
      	TabpageClose,
      }

      local TabLineOffset = {
      	condition = function(self)
      		local win = vim.api.nvim_tabpage_list_wins(0)[1]
      		local bufnr = vim.api.nvim_win_get_buf(win)
      		self.winid = win
      		if vim.bo[bufnr].filetype == "aerial" then
      			self.title = "aerial"
      			return true
      		end
      		if vim.bo[bufnr].filetype == "neo-tree" then
      			self.title = "neo-tree"
      			return true
      		end
      	end,
      	provider = function(self)
      		local title = self.title
      		local width = vim.api.nvim_win_get_width(self.winid)
      		local pad = math.ceil((width - #title) * 0.5)
      		return string.rep(" ", pad) .. title .. string.rep(" ", pad)
      	end,
      	hl = function(self)
      		if vim.api.nvim_get_current_win() == self.winid then
      			return "TablineSel"
      		else
      			return "Tabline"
      		end
      	end,
      }

      local TabLine = { TabLineOffset, BufferLine, TabPages }

      require("heirline").setup({
      	opts = { colors = colors },
      	statusline = StatusLine,
      	tabline = TabLine,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
      	callback = function(ev)
      		local bufnr = ev.buf
      		if vim.list_contains({ "wipe", "delete" }, vim.api.nvim_get_option_value("bufhidden", { buf = bufnr })) then
      			vim.bo[bufnr].buflisted = false
      		end
      	end,
      	group = vim.api.nvim_create_augroup("Heirline", {}),
      })
    '';
}
