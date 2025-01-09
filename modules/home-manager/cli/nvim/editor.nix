{pkgs, ...}: {
  programs.nixvim.extraPackages = [pkgs.ast-grep];

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
      settings = {
        engine = "astgrep";
        engines.astgrep.path = "${pkgs.ast-grep}/bin/sg";
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

    oil = {
      enable = true;
      package = pkgs.vimPlugins.oil-nvim.overrideAttrs {
        postInstall =
          # sh
          ''
            mv $out/doc/recipes.md $out/doc/oil-nvim_recipes.md
            mv $out/doc/api.md $out/doc/oil-nvim_api.md
          '';
      };
      settings = {
        delete_to_trash = true;
        float = {
          max_height = 45;
          max_width = 80;
          preview_split = "below";
        };
        preview = {
          max_height = 45;
          max_width = 80;
        };
        keymaps = {
          "<C-c>" = false;
          "<C-l>" = false;
          "<C-h>" = false;
          "<C-s>" = false;
          "<C-r>" = "actions.refresh";
          "<C-x>" = "actions.select_split";
          "<C-v>" = "actions.select_vsplit";
          "q" = "actions.close";
          "y." = "actions.copy_entry_path";
        };
      };
    };

    flash.enable = true;
    nvim-surround.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      key = "-";
      action = "<Cmd>Oil --float<CR>";
      options.desc = "Open parent directory";
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
