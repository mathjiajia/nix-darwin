{
  programs.nixvim.plugins = {
    aerial = {
      enable = true;
      lazyLoad.settings = {
        cmd = ["AerialToggle"];
        keys = [
          {
            __unkeyed-1 = "<leader>cs";
            __unkeyed-2 = "<Cmd>AerialToggle<CR>";
            desc = "Aerial (Symbols)";
          }
        ];
      };
      settings = {
        backends = ["lsp" "treesitter" "markdown" "man"];
        layout = {resize_to_content = false;};
        filter_kind = false;
        show_guides = true;
      };
    };

    fzf-lua = {
      enable = true;
      lazyLoad.settings = {
        cmd = "FzfLua";
        keys = [
          {
            __unkeyed-1 = "<leader><space>";
            __unkeyed-2 = "<Cmd>FzfLua files<CR>";
            desc = "Find Files (current)";
          }
          {
            __unkeyed-1 = "<leader>fb";
            __unkeyed-2 = "<Cmd>FzfLua buffers<CR>";
            desc = "Buffers";
          }
          {
            __unkeyed-1 = "<leader>ff";
            __unkeyed-2 = "<Cmd>FzfLua files<CR>";
            desc = "Find Files";
          }
          {
            __unkeyed-1 = "<leader>fg";
            __unkeyed-2 = "<Cmd>FzfLua git_files<CR>";
            desc = "Find Git Files";
          }
          {
            __unkeyed-1 = "<leader>fl";
            __unkeyed-2 = "<Cmd>FzfLua lsp_finder<CR>";
            desc = "Lsp Finder";
          }
          {
            __unkeyed-1 = "<leader>fo";
            __unkeyed-2 = "<Cmd>FzfLua oldfiles<CR>";
            desc = "Old Files";
          }
          {
            __unkeyed-1 = "<leader>sb";
            __unkeyed-2 = "<Cmd>FzfLua blines<CR>";
            desc = "Search Current Buffer Lines";
          }
          {
            __unkeyed-1 = "<leader>sg";
            __unkeyed-2 = "<Cmd>FzfLua live_grep<CR>";
            desc = "Live Grep";
          }
          {
            __unkeyed-1 = "<leader>sh";
            __unkeyed-2 = "<Cmd>FzfLua helptags<CR>";
            desc = "Help Tags";
          }
          {
            __unkeyed-1 = "<leader>sw";
            __unkeyed-2 = "<Cmd>FzfLua grep_cword<CR>";
            desc = "Search Word Under Cursor";
          }
          {
            mode = "v";
            __unkeyed-1 = "<leader>sw";
            __unkeyed-2 = "<Cmd>FzfLua grep_visual<CR>";
            desc = "Search Visual Selection";
          }
        ];
      };
      settings = {
        defaults = {
          file_icons = "mini";
          formatter = "path.dirname_first";
        };
        grep.RIPGREP_CONFIG_PATH = "~/.config/ripgrep/ripgreprc";
      };
      luaConfig.post =
        # lua
        ''
          require("fzf-lua").register_ui_select()
        '';
    };

    gitsigns = {
      enable = true;
      settings = {
        preview_config.border = "rounded";
        on_attach =
          # lua
          ''
            function(bufnr)
              local gitsigns = require("gitsigns")

              local function map(mode, lhs, rhs, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, lhs, rhs, opts)
              end

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
    };

    grug-far = {
      enable = true;
      lazyLoad = {
        settings = {
          cmd = "GrugFar";
          keys = [
            {
              mode = ["n" "v"];
              __unkeyed-1 = "<leader>sr";
              __unkeyed-2.__raw =
                # lua
                ''
                  function()
                  	local grug = require("grug-far")
                  	local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                  	grug.open({ prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil } })
                  end
                '';
              desc = "Search and Replace";
            }
          ];
        };
      };
    };
    flash.enable = true;

    nvim-bqf = {
      enable = true;
      preview = {
        winHeight = 5;
        winVheight = 5;
      };
    };

    nvim-surround.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      mode = ["n" "x" "o"];
      key = "s";
      action.__raw =
        # lua
        ''
          function() require("flash").jump() end
        '';
      options.desc = "Flash";
    }
    {
      mode = ["n" "x" "o"];
      key = "S";
      action.__raw =
        # lua
        ''
          function() require("flash").treesitter() end
        '';
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o";
      key = "r";
      action.__raw =
        # lua
        ''
          function() require("flash").remote() end
        '';
      options.desc = "Remote Flash";
    }
    {
      mode = ["x" "o"];
      key = "R";
      action.__raw =
        # lua
        ''
          function() require("flash").treesitter_search() end
        '';
      options.desc = "Treesitter Search";
    }
    {
      mode = "c";
      key = "<C-s>";
      action.__raw =
        # lua
        ''
          function() require("flash").toggle() end
        '';
      options.desc = "Toggle Flash Search";
    }
  ];
}
