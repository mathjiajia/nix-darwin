{ neovim-nightly-overlay, pkgs, ... }:
{
  programs.nixvim.enable = true;
  programs.nixvim.package = neovim-nightly-overlay.packages.${pkgs.system}.default;
  programs.nixvim.extraPackages = with pkgs; [
    tree-sitter
    nodejs # for copilot.lua
    # libgit2 # c library to interact with git repositories, needed by fugit2.nvim plugin
    # lua51Packages.lua
    luajit
    luajitPackages.luarocks
  ];
  programs.nixvim.vimdiffAlias = true;
  programs.nixvim.defaultEditor = true;
  programs.nixvim.diagnostics = {
    virtual_lines.only_current_line = true;
    virtual_text = true;
  };
  programs.nixvim.globals = {
    # mapleader = " ";
    # maplocalleader = " ";
    # Disable useless providers
    loaded_ruby_provider = 0; # Ruby
    loaded_perl_provider = 0; # Perl
    loaded_python_provider = 0; # Python 2

  };
  programs.nixvim.clipboard = {
    # Use system clipboard
    register = "unnamedplus";
  };

  programs.nixvim.opts = {
    # 1 important

    # 2 moving around, seaching patterns
    whichwrap = "b,s,[,]";
    ignorecase = true;
    smartcase = true;

    # 3 tags

    # 4 displaying text
    smoothscroll = true;
    scrolloff = 12;
    linebreak = true;
    breakindent = true;
    showbreak = "> ";
    fillchars = {
      diff = "╱";
      eob = " ";
      fold = " ";
    };
    cmdheight = 0;
    number = true;
    relativenumber = true;

    # 5 syntax, highlighting and spelling
    colorcolumn = "120";
    cursorline = true;
    spelllang = "en_gb";

    # 6 multiple windows
    laststatus = 3;
    splitbelow = true;
    splitkeep = "screen";
    splitright = true;

    # 7 multiple tab pages

    # 8 terminal

    # 9 using the mouse

    # 10 messages and info
    shortmess = "ltToOCFWIc";
    confirm = true;

    # 11 selecting text

    # 12 editing text
    undofile = true;
    formatoptions = "tcroqnlj";
    pumheight = 10;

    # 13 tabs and indenting
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;

    # 14 folding
    foldmethod = "expr";
    foldexpr = "v:lua.vim.treesitter.foldexpr()";
    foldlevel = 99;
    foldtext = "";

    # 15 diff mode
    diffopt = "internal,filler,closeoff,linematch:90";

    # 16 mapping
    timeoutlen = 500;

    # 17 reading and writng files

    # 18 the swap file
    swapfile = false;
    updatetime = 200;

    # 19 command line editing

    # 20 executing external commands

    # 21 running make and jumping to errors (quickfix)

    # 22 language specific

    # 23 multi-byte characters

    # 24 various
    virtualedit = "block";
    signcolumn = "yes";
  };

  programs.nixvim.autoGroups =
    let
      togroup =
        strings:
        builtins.listToAttrs (
          map (s: {
            name = s;
            value = {
              clear = true;
            };
          }) strings
        );
    in

    togroup [
      "CheckTime"
      "HighlightYank"
      "UserLspConfig"
      "LastPlace"
      "openFile"
    ];

  programs.nixvim.autoCmd = [
    {
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      group = "CheckTime";
      callback.__raw = ''
        function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd.checktime()
          end
        end
      '';
    }
    {
      event = [ "TextYankPost" ];
      desc = "Highlight the Yanked Text";
      group = "HighlightYank";
      callback.__raw = ''
        function()
          vim.highlight.on_yank()
        end
      '';
    }
    {
      event = [ "BufReadPost" ];
      desc = "Last Position";
      group = "LastPlace";
      callback.__raw = ''
                function(event)
        					local exclude_bt = { "help", "nofile", "quickfix" }
        					local exclude_ft = { "gitcommit" }
        					local buf = event.buf
        					if
        						vim.list_contains(exclude_bt, vim.bo[buf].buftype)
        						or vim.list_contains(exclude_ft, vim.bo[buf].filetype)
        						or vim.api.nvim_win_get_cursor(0)[1] > 1
        						or vim.b[buf].last_pos
        					then
        						return
        					end
        					vim.b[buf].last_pos = true
        					local mark = vim.api.nvim_buf_get_mark(buf, '"')
        					local lcount = vim.api.nvim_buf_line_count(buf)
        					if mark[1] > 0 and mark[1] <= lcount then
        						pcall(vim.api.nvim_win_set_cursor, 0, mark)
        					end
        				end
        			'';
    }
    {
      event = [ "FileType" ];
      desc = "Enable Treesitter";
      callback.__raw = ''
                function(ev)
        					if not pcall(vim.treesitter.start, ev.buf) then
        						return
        					end

        					vim.opt_local.foldmethod = "expr"
        					vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        				end
        			'';
    }
    {
      event = [ "BufReadPost" ];
      group = "openFile";
      pattern = [
        "*.jpeg"
        "*.jpg"
        "*.pdf"
        "*.png"
      ];
      callback.__raw = ''
        function(ev)
        	vim.fn.jobstart("open '" .. vim.fn.expand("%") .. "'", { detach = true })
        	vim.api.nvim_buf_delete(ev.buf, {})
        end
      '';
    }
    {
      event = [ "BufWritePost" ];
      pattern = [ "*/spell/*.add" ];
      callback.__raw = ''
        				function()
                  vim.cmd.mkspell({ "%", bang = true, mods = { silent = true } })
        				end
        			'';
    }
  ];

  # TODO: make a keybind `<leader>a` that check if there is a code action available for the cursor position, and opens a panel to select a handler
  # if not then check if there is a mispell and suggest `z=`
  # if not then go to next code action or mispell, whichever is closest.
  programs.nixvim.keymaps =
    let
      mode = [
        "n"
        "x"
      ];
      cmd = verb: "<cmd>${verb}<cr>";
      leader = keys: "<leader>${keys}";
      ctrl = key: "<c-${key}>";
    in

    [
      {
        mode = [
          "n"
          "x"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options.expr = true;
        options.silent = true;
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options.expr = true;
        options.silent = true;
      }
      {
        key = "<leader>bd";
        mode = [ "n" ];
        action.__raw = ''
                    function()
          						vim.api.nvim_buf_delete(0, {})
          					end
        '';
        options.desc = "Delete Buffer";
      }
      {
        key = "<leader>bD";
        mode = [ "n" ];
        action.__raw = ''
                    function()
          						vim.api.nvim_buf_delete(0, { force = true })
          					end
          				'';
        options.desc = "Delete Buffer (force)";
      }
    ];

  programs.nixvim.plugins.lsp = {
    enable = true;
    capabilities = "require('cmp_nvim_lsp').default_capabilities()";
    inlayHints = true;
    # onAttach = ''
    # 	function(client, bufnr)
    # 			local methods = vim.lsp.protocol.Methods
    #
    # 			if client.supports_method(methods.textDocument_documentHighlight) then
    # 				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    # 					buffer = bufnr,
    # 					callback = vim.lsp.buf.document_highlight,
    # 				})
    # 				vim.api.nvim_create_autocmd("CursorMoved", {
    # 					buffer = bufnr,
    # 					callback = vim.lsp.buf.clear_references,
    # 				})
    # 			end
    # 		end
    # '';
    keymaps.lspBuf = {
      gD = "declaration";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
      "<C-k>" = "signature_help";
    };
    servers = {
      basedpyright.enable = true;
      clangd.enable = true;
      lua_ls = {
        enable = true;
        settings = {
          completion.callSnippet = "Replace";
          hint.enable = true;
          telemetry.enable = false;
          workspace.checkThirdParty = false;
        };
      };
      matlab_ls = {
        enable = true;
        settings = {
          MATLAB = {
            indexWorkspace = true;
            installPath = "/Applications/MATLAB_R2024b.app";
            telemetry = false;
          };
        };
      };
      nil_ls.enable = true;
      sourcekit = {
        enable = true;
        package = null;
        filetypes = [
          "swift"
          "objc"
          "objcpp"
        ];
      };
      taplo.enable = true;
      texlab = {
        enable = true;
        settings = {
          texlab = {
            build = {
              args = [
                "-interaction=nonstopmode"
                "-synctex=1"
                "%f"
              ];
              forwardSearchAfter = false;
              onSave = true;
            };
            forwardSearch = {
              executable = "/Applications/sioyek.app/Contents/MacOS/sioyek";
              args = [
                "--reuse-window"
                "--execute-command"
                "turn_on_synctex"
                "--inverse-search"
                "texlab inverse-search --input %%1 --line %%2"
                "--forward-search-file"
                "%f"
                "--forward-search-line"
                "%l"
                "%p"
              ];
            };
            diagnostics.ignoredPatterns = [
              "^Overfull"
              "^Underfull"
            ];
          };
        };
      };
    };
  };

  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters = {
        latexindent.prepend_args = [
          "-c"
          "./.aux"
          "-m"
        ];
        bibtex-tidy.prepend_args = [
          "--curly"
          "--tab"
          "--trailing-commas"
          "--sort-fields=author,year,month,day,title,shorttitle"
          "--remove-braces"
        ];
      };
      formatters_by_ft = {
        bib = [ "bibtex-tidy" ];
        c = [ "clang-format" ];
        css = [ "prettierd" ];
        html = [ "prettierd" ];
        javascript = [ "prettierd" ];
        json = [ "prettierd" ];
        jsonc = [ "prettierd" ];
        fish = [ "fish_indent" ];
        markdown = [ "prettierd" ];
        "markdown.mdx" = [ "prettierd" ];
        yaml = [ "prettierd" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        python = [ "black" ];
        sh = [ "shfmt" ];
        swift = [ "swift_format" ];
        tex = [ "latexindent" ];
        toml = [ "taplo" ];
      };
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 2000;
      };
    };
  };

  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      bash = [ "shellcheck" ];
      fish = [ "fish" ];
      gitcommit = [ "commitlint" ];
      markdown = [ "markdownlint-cli2" ];
      zsh = [ "shellcheck" ];
    };
  };

  # programs.nixvim.plugins.lz-n = {
  #   enable = true;
  # };

  programs.nixvim.plugins.lazy = {
    enable = true;
    plugins = [
      # {
      #   pkg = "nvchad/base46";
      #   lazy = true;
      #   build.__raw = ''
      #     function()
      #     	require("base46").load_all_highlights()
      #     end'';
      # }
      # {
      # 	"nvchad/ui",
      # 	config = function()
      # 		require("nvchad")
      # 	end,
      # }
      # { "nvchad/volt"; lazy = true; }
      # { "nvchad/menu", lazy = true }
      # { "nvchad/minty", cmd = { "Shades", "Huefy" } }
      # { "nvchad/timerly", cmd = "TimerlyToggle" }
      # { "nvchad/showkeys", cmd = "ShowkeysToggle" }
    ];
  };

  programs.nixvim.plugins.fzf-lua = {
    enable = false;
    settings = {
      # grep.RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH;
      defaults = {
        file_icons = "mini";
        formatter = "path.dirname_first";
      };
    };
  };
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    # open_files_do_not_replace_types = { "aerial"; "qf"; "terminal"; };
    defaultComponentConfigs.indent.withExpanders = true;
    filesystem = {
      bindToCwd = false;
      followCurrentFile.enabled = true;
      useLibuvFileWatcher = true;
      filteredItems = {
        hideDotfiles = false;
        hideGitignored = true;
        hideByName = [ ".git" ];
      };
    };
  };
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };

    settings = {
      extensions.__raw = "{ ['ui-select'] = { require('telescope.themes').get_dropdown() } }";
    };
  };
  programs.nixvim.plugins.rainbow-delimiters.enable = true;
  programs.nixvim.plugins.noice = {
    enable = true;
    lsp.override = {
      "vim.lsp.util.convert_input_to_markdown_lines" = true;
      "vim.lsp.util.stylize_markdown" = true;
      "cmp.entry.get_documentation" = true;
    };
    presets = {
      bottom_search = true;
      command_palette = true;
      long_message_to_split = true;
      lsp_doc_border = true;
    };
    routes = [
      {
        filter = {
          event = "msg_show";
          any = [
            { find = "%d+L, %d+B"; }
            { find = "; after #%d+"; }
            { find = "; before #%d+"; }
          ];
        };
        view = "mini";
      }
    ];
  };

  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      exclude.filetypes = [
        "conf"
        "dashboard"
        "markdown"
      ];
      scope.highlight = [
        "RainbowRed"
        "RainbowYellow"
        "RainbowBlue"
        "RainbowOrange"
        "RainbowGreen"
        "RainbowViolet"
        "RainbowCyan"
      ];
    };
    luaConfig.pre = ''
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)
    '';
    luaConfig.post = ''
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    '';
  };
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings.on_attach = ''
      function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- stylua: ignore start
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff This (File)" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end
    '';
  };
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = false;
      ensure_installed = [
        "bash"
        "bibtex"
        "c"
        "comment"
        "commonlisp"
        "csv"
        "editorconfig"
        "diff"
        "glsl"
        "fish"
        "git_config"
        "git_rebase"
        "gitattributes"
        "gitcommit"
        "gitignore"
        "html"
        "json"
        "jsonc"
        "latex"
        "lua"
        "luadoc"
        "luap"
        "markdown"
        "markdown_inline"
        "matlab"
        "nix"
        "python"
        "r"
        "requirements"
        "query"
        "regex"
        "swift"
        "todotxt"
        "toml"
        "typst"
        "vim"
        "vimdoc"
        "yaml"
      ];
      indent.enable = true;
      highlight = {
        enable = true;
      };
    };
  };

  programs.nixvim.plugins.luasnip = {
    enable = true;
    settings = {
      update_events = "TextChanged,TextChangedI";
      delete_check_events = "TextChanged";
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
  };

  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "path"; }
      { name = "buffer"; }
    ];
    settings.completion.completeopt = "menu,menuone,noinsert";
    settings.mapping = {
      "<C-n>" = "cmp.mapping.select_next_item()";
      "<C-p>" = "cmp.mapping.select_prev_item()";
      "<C-y>" = "cmp.mapping.confirm { select = true }";
      "<C-Space>" = "cmp.mapping.complete {}";
    };
  };

  # programs.nixvim.plugins.diffview = {
  #   enable = true;
  #   enhancedDiffHl = true;
  # };

  programs.nixvim.plugins.toggleterm = {
    enable = true;
    settings = {
      float_opts = {
        border = "rounded";
      };
      open_mapping = "[[<C-Bslash>]]";
    };
    luaConfig.post = ''
      local Terminal = require("toggleterm.terminal").Terminal
      local float_opts = { width = vim.o.columns, height = vim.o.lines }

      local btop = Terminal:new({ cmd = "btop", hidden = true, direction = "float", float_opts = float_opts })
      local lazygit = Terminal:new({
      	cmd = "lazygit",
      	dir = "git_dir",
      	hidden = true,
      	direction = "float",
      	float_opts = float_opts,
      })

      vim.keymap.set({ "n", "t" }, "<leader>ti", function() btop:toggle() end)
      vim.keymap.set({ "n", "t" }, "<leader>tg", function() lazygit:toggle() end)
    '';
  };
  programs.nixvim.plugins.overseer = {
    enable = true;
    settings = {
      dap = false;
      strategy = "toggleterm";
      templates = [
        "builtin"
        "user.builder"
        "user.runner"
      ];
    };
  };

  programs.nixvim.plugins.sniprun = {
    enable = true;
    settings = {
      display = [
        "VirtualTextOk"
        "VirtualTextErr"
        "Terminal"
      ];
      selected_interpreters = [
        "Generic"
        "Lua_nvim"
        "Python3_fifo"
      ];
      repl_enable = [
        "Bash_original"
        "Lua_nvim"
        "Python3_fifo"
        "R_original"
      ];
      interpreter_options = {
        Generic = {
          Swift_original = {
            supported_filetypes = [ "swift" ];
            extension = ".swift";
            interpreter = "swift";
            boilerplate_pre = "import Foundation";
          };
        };
      };
    };
  };
  programs.nixvim.plugins.nvim-surround.enable = true;
  programs.nixvim.plugins.flash.enable = true;
  programs.nixvim.plugins.markview.enable = true;
  programs.nixvim.plugins.twilight.enable = true;
  programs.nixvim.plugins.zen-mode = {
    enable = true;
    settings = {
      plugins.gitsigns.enabled = false;
    };
  };
  programs.nixvim.plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules.icons = {
      lsp = {
        "function".glyph = "";
        object.glyph = "";
        value.glyph = "";
      };
    };
  };

  programs.nixvim.plugins.notify.enable = true;
  programs.nixvim.colorschemes.tokyonight = {
    enable = true;
    settings.style = "night";
  };

  programs.nixvim.performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
