{
  programs.nixvim.plugins = {
    aerial = {
      enable = true;
      settings = {
        backends = ["lsp" "treesitter" "markdown" "man"];
        layout = {resize_to_content = false;};
        filter_kind = false;
        show_guides = true;
      };
    };

    fzf-lua = {
      enable = true;
      keymaps = {
        "<leader><space>" = {
          action = "files";
          options.desc = "Find Files (current)";
        };
        "<leader>fb" = {
          action = "buffers";
          options.desc = "Buffers";
        };
        "<leader>fc" = {
          action = "files";
          options.desc = "Find Config File";
        };
        "<leader>ff" = {
          action = "files";
          options.desc = "Find Files (cwd)";
        };
        "<leader>fg" = {
          action = "git_files";
          options.desc = "Find Git Files";
        };
        "<leader>fl" = {
          action = "lsp_finder";
          options.desc = "Lsp Finder";
        };
        "<leader>fo" = {
          action = "oldfiles";
          options.desc = "Old Files";
        };
        "<leader>sb" = {
          action = "blines";
          options.desc = "Search Current Buffer Lines";
        };
        "<leader>sg" = {
          action = "live_grep";
          options.desc = "Live Grep";
        };
        "<leader>sh" = {
          action = "helptags";
          options.desc = "Help Tags";
        };
        "<leader>sw" = {
          action = "grep_cword";
          options.desc = "Search Word Under Cursor";
        };
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

    grug-far.enable = true;
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
      mode = "v";
      key = "<leader>sw";
      action = "FzfLua grep_visual";
      options.desc = "Search Visual Selection";
    }

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
