{pkgs, ...}: let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "master";
      hash = "sha256-5mHU0QtdMBtoUGBvKiFfNEn5T8MSzPWLOqmll2kWrMU=";
    };
  };

  latex-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "latex";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "latex.nvim";
      rev = "master";
      hash = "sha256-9RwMlelpXxZS054cE5OVP/PHOnP0I9GLfBqgVESi4xU=";
    };
  };

  nvim-treesitter-pairs = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-pairs";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "nvim-treesitter-pairs";
      rev = "master";
      hash = "sha256-Nr8h0yUpJMfRx+VZ3Jf03p3tCeSc7JWiwtruqkjzzkw=";
    };
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    aerial-nvim
    dropbar-nvim
    grug-far-nvim
    nvim-highlight-colors
    resession-nvim
    ultimate-autopair-nvim

    latex-nvim
    mysnippets
    nvim-treesitter-pairs
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      local modes = {
      	n = "N",
      	no = "N?",
      	nov = "N?",
      	noV = "N?",
      	["no\22"] = "N?",
      	niI = "Ni",
      	niR = "Nr",
      	niV = "Nv",
      	nt = "Nt",
      	v = "V",
      	vs = "Vs",
      	V = "V_",
      	Vs = "Vs",
      	["\22"] = "^V",
      	["\22s"] = "^V",
      	s = "S",
      	S = "S_",
      	["\19"] = "^S",
      	i = "I",
      	ic = "Ic",
      	ix = "Ix",
      	R = "R",
      	Rc = "Rc",
      	Rx = "Rx",
      	Rv = "Rv",
      	Rvc = "Rc",
      	Rvx = "Rv",
      	c = "C",
      	cv = "Ex",
      	r = "...",
      	rm = "M",
      	["r?"] = "?",
      	["!"] = "!",
      	t = "T",
      }

      local mode = function()
      	local current_mode = vim.api.nvim_get_mode().mode
      	return string.format("%%#MatchParen# %s %%*", modes[current_mode])
      end

      local formatted_filetype = function()
      	local filetype = vim.bo.filetype or vim.fn.expand("%:e", false)
      	local icon, hlgroup = MiniIcons.get("filetype", filetype)
      	return string.format("%%#%s# %s %s %%*", hlgroup, icon, filetype)
      end

      local workspace = function()
      	local icon = " " .. (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. "  "
      	local cwd = vim.fn.getcwd(0)
      	local path = vim.fn.fnamemodify(cwd, ":~")
      	path = vim.fn.pathshorten(path)
      	local trail = path:sub(-1) == "/" and "" or "/"
      	return icon .. path .. trail
      end

      local GIT_ATTRS = {
      	{ "added", "diffAdded#+" },
      	{ "changed", "diffChanged#~" },
      	{ "removed", "diffRemoved#-" },
      }

      local git_branch = function()
      	local branch = vim.b.gitsigns_head
      	return branch and " %#diffOldFile# %*" .. branch or ""
      end

      local git_hunks = function()
      	local hunks = {}
      	local gsd = vim.b.gitsigns_status_dict

      	if gsd then
      		for i, attr in ipairs(GIT_ATTRS) do
      			local count = gsd[attr[1]] or 0
      			if count > 0 then
      				table.insert(hunks, string.format("%%#%s%s", attr[2], count))
      			end
      		end
      	end

      	return table.concat(hunks, " ")
      end

      local DIAG_ATTRS = {
      	{ "DiagnosticSignError", vim.diagnostic.severity.ERROR },
      	{ "DiagnosticSignWarn", vim.diagnostic.severity.WARN },
      	{ "DiagnosticSignInfo", vim.diagnostic.severity.INFO },
      	{ "DiagnosticSignHint", vim.diagnostic.severity.HINT },
      }

      local diagnostics = function()
      	local status = {}
      	local diags = vim.diagnostic.count(0)
      	for i, attr in ipairs(DIAG_ATTRS) do
      		local count = diags[i] or 0
      		if count > 0 then
      			table.insert(status, string.format("%%#%s# ● %s%%*", attr[1], count))
      		end
      	end
      	return #status > 0 and table.concat(status, " ") or ""
      end

      local lsp_active = function()
      	local names = {}
      	for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      		table.insert(names, server.name)
      	end

      	if #names == 0 then
      		return ""
      	end

      	return "%#Special# [" .. table.concat(names, " ") .. "] "
      end

      local progress = "%#LspReferenceText# %7(%l/%3L%):%2c %P "

      local scrollbar = function()
      	local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
      	local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      	local lines = vim.api.nvim_buf_line_count(0)
      	local i = math.floor((curr_line - 1) / lines * 8) + 1
      	return string.rep(sbar[i], 2)
      end

      StatusLine = {}

      StatusLine.inactive = function()
      	return table.concat({ formatted_filetype("String") })
      end

      local redeable_filetypes = { qf = true, help = true }

      StatusLine.active = function()
      	local mode_str = vim.api.nvim_get_mode().mode
      	if mode_str == "t" or mode_str == "nt" then
      		return table.concat({ mode(), "%=", progress })
      	end

      	if redeable_filetypes[vim.bo.filetype] or vim.o.modifiable == false then
      		return table.concat({ formatted_filetype("Special"), "%=", progress })
      	end

      	local statusline = {
      		mode(),
      		workspace(),
      		"%f%m%r",
      		git_branch(),
      		" ",
      		git_hunks(),
      		"%=",
      		"%S ",
      		diagnostics(),
      		lsp_active(),
      		progress,
      		scrollbar(),
      		" ",
      	}

      	return table.concat(statusline)
      end

      vim.opt.statusline = "%!v:lua.StatusLine.active()"

      vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
      	group = vim.api.nvim_create_augroup("simple_statusline", { clear = true }),
      	pattern = { "aerial", "fzf", "lspinfo", "neo-tree", "noice", "qf" },
      	callback = function()
      		vim.opt_local.statusline = "%!v:lua.StatusLine.inactive()"
      	end,
      })

      require("dropbar").setup()
      require("grug-far").setup({ headerMaxWidth = 80 })
      require("nvim-highlight-colors").setup()
      require("resession").setup()
      require("ultimate-autopair").setup()

      require("aerial").setup({
      	backends = { "lsp", "treesitter", "markdown", "man" },
      	layout = { resize_to_content = false },
      	filter_kind = false,
      	show_guides = true,
      })
    '';

  programs.nixvim.keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>sr";
      action.__raw =
        # lua
        ''
          function()
            local grug = require("grug-far")
            local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
            grug.open({ prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil } })
          end
        '';
      options.desc = "Search and Replace";
    }

    {
      key = "<leader>cs";
      action = "<Cmd>AerialToggle<CR>";
      options.desc = "Aerial (Symbols)";
    }

    {
      key = "<leader>ss";
      action.__raw =
        # lua
        ''
          function()
          	require("resession").save()
          end
        '';
      options.desc = "Save Session";
    }
    {
      key = "<leader>sl";
      action.__raw =
        # lua
        ''
          function()
          	require("resession").load()
          end
        '';
      options.desc = "Load Session";
    }
    {
      key = "<leader>sd";
      action.__raw =
        # lua
        ''
          function()
          	require("resession").delete()
          end
        '';
      options.desc = "Delete Session";
    }
  ];
}
