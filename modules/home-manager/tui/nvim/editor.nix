{
  programs.nixvim.plugins = {
    flash.enable = true;
    nvim-surround.enable = true;

    aerial = {
      enable = true;
      settings = {
        backends = ["lsp" "treesitter" "markdown" "man"];
        filter_kind = false;
        nerd_font = true;
        show_guides = true;
      };
    };

    grug-far = {
      enable = true;
      settings = {
        icons.fileIconsProvider = "mini.icons";
        keymaps.close.n = "q";
      };
    };

    nvim-bqf = {
      enable = true;
      preview = {
        winHeight = 5;
        winVheight = 5;
      };
    };

    gitsigns = {
      enable = true;
      settings = {
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
            		if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gitsigns.nav_hunk("next") end
            	end)

            	map("n", "[c", function()
            		if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gitsigns.nav_hunk("prev") end
            	end)

            	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
            	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
            	map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
            	map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
            	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
            	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
            	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
            	map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })
            	map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
            	map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
            	map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff This (File)" })
            	map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "Set qflist (all)" })
            	map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set qflist" })
            	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
            	map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })
            	map("n", '<leader>tw', gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })
            	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end
          '';
        preview_config.border = "rounded";
      };
    };
  };

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
      mode = ["n" "x" "o"];
      key = "s";
      action.__raw = ''function() require("flash").jump() end'';
      options.desc = "Flash";
    }
    {
      mode = ["n" "x" "o"];
      key = "S";
      action.__raw = ''function() require("flash").treesitter() end'';
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o";
      key = "r";
      action.__raw = ''function() require("flash").remote() end'';
      options.desc = "Remote Flash";
    }
    {
      mode = ["x" "o"];
      key = "R";
      action.__raw = ''function() require("flash").treesitter_search() end'';
      options.desc = "Treesitter Search";
    }
    {
      mode = "c";
      key = "<C-s>";
      action.__raw = ''function() require("flash").toggle() end'';
      options.desc = "Toggle Flash Search";
    }
  ];
}
