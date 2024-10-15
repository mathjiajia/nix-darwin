{
  config,
  pkgs,
  lib,
  neovim-nightly-overlay,
  ...
}:
# let
#   fromGitHub =
#     owner: repo: ref: hash:
#     pkgs.vimUtils.buildVimPlugin {
#       pname = "${lib.strings.sanitizeDerivationName repo}";
#       version = ref;
#       src = pkgs.fetchFromGitHub {
#         owner = owner;
#         repo = repo;
#         rev = ref;
#         sha256 = hash;
#       };
#     };
#
# in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lz-n;
        type = "lua";
        config = ''
          require("lz.n").load("plugins")
        '';
      }

      # coding
      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile ./lua/luasnip.lua;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./lua/cmp.lua;
      }
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-rg
      cmp_luasnip
      copilot-cmp
      {
        plugin = copilot-lua;
        type = "lua";
        config = ''
                    require("copilot").setup({
                    panel = { enabled = false },
          			suggestion = { enabled = false }
                })
        '';
      }
      {
        plugin = ultimate-autopair-nvim;
        type = "lua";
        config = ''
          require("ultimate-autopair").setup()
        '';
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup {}
        '';
      }

      # dap
      {
        plugin = nvim-dap;
        type = "lua";
        config = builtins.readFile ./lua/dap.lua;
      }
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config = builtins.readFile ./lua/dap-ui.lua;
      }
      {
        plugin = nvim-dap-virtual-text;
        type = "lua";
        config = ''
          require("nvim-dap-virtual-text").setup()
        '';
      }
      nvim-nio

      # editor
      {
        plugin = oil-nvim;
        type = "lua";
        config = ''
                    require("oil").setup({
                    float = {
          				max_width = vim.fn.round(vim.o.columns * 0.5),
          				max_height = vim.fn.round(vim.o.lines * 0.5),
          			}
                })
        '';
      }
      {
        plugin = grug-far-nvim;
        type = "lua";
        config = ''
          require("grug-far").setup({headerMaxWidth = 80})
        '';
      }
      {
        plugin = fzf-lua;
        type = "lua";
        config = ''
              require("fzf-lua").setup({
              defaults = {
          				file_icons = "mini",
          				formatter = "path.dirname_first",
          			}
                })
        '';
      }
      {
        plugin = flash-nvim;
        type = "lua";
        config = ''
              require("flash").setup()

              vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
          			vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
          			vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
          			vim.keymap.set({ "x", "o" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
          			vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./lua/gitsigns.lua;
      }
      # {
      #   plugin = quicker-nvim;
      #   type = "lua";
      #   config = ''
      #     require("quicker").setup({
      #     keys = {
      # 	{ ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "Expand quickfix context" },
      # 	{ "<", function() require("quicker").collapse() end, desc = "Collapse quickfix context" },
      # }
      # })
      #   '';
      # }
      {
        plugin = aerial-nvim;
        type = "lua";
        config = ''
                    require("aerial").setup({
                    backends = { "lsp", "treesitter", "markdown", "man" },
          			layout = { resize_to_content = false },
          			filter_kind = false,
          			show_guides = true,
                })
        '';
      }

      # lang
      {
        plugin = lazydev-nvim;
        type = "lua";
        config = ''
                    require("lazydev").setup({
                    library = {
          				-- Load luvit types when the `vim.uv` word is found
          				{ path = "luvit-meta/library", words = { "vim%.uv" } },
          			},
                })
        '';
      }
      luvit-meta

      # lsp
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lua/lspconfig.lua;
      }
      {
        plugin = mason-nvim;
        type = "lua";
        config = ''
          require("mason").setup {
            ui = { border = "rounded", height = 0.8 }
          }
        '';
      }
      mason-tool-installer-nvim
      {
        plugin = conform-nvim;
        type = "lua";
        config = builtins.readFile ./lua/conform.lua;
      }
      {
        plugin = nvim-lint;
        type = "lua";
        config = builtins.readFile ./lua/lint.lua;
      }

      # ui
      {
        plugin = bamboo-nvim;
        config = ''
          require("lz.n").load {
            "bamboo.nvim",
            colorscheme = "bamboo",
          }
        '';
        type = "lua";
      }
      {
        plugin = nvim-notify;
        type = "lua";
        config = ''
                    require("notify").setup({
                    max_height = function()
          				return math.floor(vim.o.lines * 0.75)
          			end,
          			max_width = function()
          				return math.floor(vim.o.columns * 0.75)
          			end,
          			on_open = function(win)
          				vim.api.nvim_win_set_config(win, { zindex = 100 })
          			end,
          			timeout = 3000,
                    })
        '';
      }
      {
        plugin = dressing-nvim;
        type = "lua";
        config = ''
          require("dressing").setup()
        '';
      }
      {
        plugin = nvim-highlight-colors;
        type = "lua";
        config = ''
          require("nvim-highlight-colors").setup({
          exclude_buftypes = { "nofile" }
          })
        '';
      }
      {
        plugin = dropbar-nvim;
        type = "lua";
        config = ''
          require("dropbar").setup()
        '';
      }
      {
        plugin = statuscol-nvim;
        type = "lua";
        config = ''
          require("statuscol").setup()
        '';
      }
      {
        plugin = heirline-nvim;
        type = "lua";
        config = builtins.readFile ./lua/heirline.lua;
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = builtins.readFile ./lua/indent-blankline.lua;
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = builtins.readFile ./lua/noice.lua;
      }
      {
        plugin = dashboard-nvim;
        type = "lua";
        config = builtins.readFile ./lua/dashboard.lua;
      }
      {
        plugin = zen-mode-nvim;
        type = "lua";
        config = ''
          require("zen-mode").setup({
          plugins = { gitsigns = { enabled = false } }
          })
        '';
      }
      {
        plugin = twilight-nvim;
        type = "lua";
        config = ''
          require("twilight").setup({})
        '';
      }
      {
        plugin = rainbow-delimiters-nvim;
        type = "lua";
        config = ''
          vim.g.rainbow_delimiters = { query = { latex = "rainbow-delimiters" } }
        '';
      }
      {
        plugin = mini-icons;
        type = "lua";
        config = builtins.readFile ./lua/mini-icons.lua;
      }

      # util
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = builtins.readFile ./lua/toggleterm.lua;
      }
      {
        plugin = resession-nvim;
        type = "lua";
        config = ''
          require("resession").setup()
        '';
      }
      nui-nvim

      {
        plugin = nvim-treesitter.withPlugins (
          plugins: with plugins; [
            bash
            bibtex
            c
            comment
            diff
            fish
            html
            latex
            lua
            luadoc
            luap
            markdown
            markdown_inline
            matlab
            python
            query
            regex
            swift
            toml
            vim
            vimdoc
          ]
        );
        type = "lua";
        config = builtins.readFile ./lua/treesitter.lua;
      }
    ];
  };

  #   xdg.configFile."nvim" = {
  #     source = config.lib.file.mkOutOfStoreSymlink ./config;
  #   };
}
