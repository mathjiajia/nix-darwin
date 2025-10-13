{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = [ pkgs.vimPlugins.fyler-nvim ];

  programs.nixvim.plugins = {
    flash.enable = true;
    grug-far.enable = true;
    nvim-surround.enable = true;

    fff = {
      enable = true;
      settings = {
        lazy_sync = true;
        layout.prompt_position = "top";
      };
    };

    gitsigns = {
      enable = true;
      settings.on_attach =
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
          	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
          	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
          	map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline" })
          	map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
          	map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
          	map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff This (File)" })
          	map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "Set qflist (all)" })
          	map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set qflist" })
          	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
          	map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle Word Diff" })
          	map({ "o", "x" }, "ih", gitsigns.select_hunk)
          end
        '';
    };

    snacks = {
      enable = true;
      package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          oldAttrs.postInstall or ""
          # sh
          + ''mkdir --parents $out/after/; mv $out/queries/ $out/after/queries/'';
      });
      settings = {
        input.enabled = true;
        picker.win.input.keys."<M-d>" = {
          __unkeyed-1 = "toggle_hidden";
          mode = [
            "n"
            "i"
          ];
        };
        styles.lazygit = {
          width = 0;
          height = 0;
        };
      };
    };
  };

  programs.nixvim.extraConfigLua = ''
    require("fyler").setup({
    	default_explorer = true,
    	hooks = {
    		on_rename = function(src_path, destination_path)
    			Snacks.rename.on_rename_file(src_path, destination_path)
    		end,
    	},
    	icon = {
    		directory_collapsed = "",
    		directory_expanded = "",
    		directory_empty = "󰜌",
    	},
    	win = {
    		kind = "split_left",
    		kind_presets = { split_left = { width = "0.2rel" } },
        win_opts = {
          number = false,
          relativenumber = false,
        },
    	},
    })
  '';

  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>sr";
      action.__raw = ''
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({ prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil } })
        end
      '';
      options.desc = "Search and Replace";
    }

    {
      mode = "n";
      key = "<leader>e";
      action = "<Cmd>Fyler<CR>";
      options.desc = "Open File Picker";
    }

    {
      mode = "n";
      key = "<leader>ff";
      action = "<Cmd>FFFFind<CR>";
      options.desc = "Open File Picker";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = ''function() require("fff").find_in_git_root() end'';
      options.desc = "Find Git Files";
    }

    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action.__raw = ''function() require("flash").jump() end'';
      options.desc = "Flash";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
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
      mode = [
        "x"
        "o"
      ];
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

    # Picker
    # Top
    {
      mode = "n";
      key = "<leader><space>";
      action.__raw = ''function() Snacks.picker.smart() end'';
      options.desc = "Smart Open";
    }
    {
      mode = "n";
      key = "<leader>n";
      action.__raw = ''function() Snacks.picker.notifications() end'';
      options.desc = "Notification History";
    }
    # Find
    {
      mode = "n";
      key = "<leader>fb";
      action.__raw = ''function() Snacks.picker.buffers({ layout = "select" }) end'';
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>fm";
      action.__raw = ''function() Snacks.picker({ layout = "select" }) end'';
      options.desc = "Snacks Picker";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action.__raw = ''function() Snacks.picker.projects() end'';
      options.desc = "Projects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action.__raw = ''function() Snacks.picker.recent() end'';
      options.desc = "Recent";
    }
    # git
    {
      mode = "n";
      key = "<leader>gd";
      action.__raw = ''function() Snacks.picker.git_diff() end'';
      options.desc = "Git Diff (Hunks)";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action.__raw = ''function() Snacks.picker.git_log_file() end'';
      options.desc = "Git Log File";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = ''function() Snacks.picker.git_log() end'';
      options.desc = "Git Log";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action.__raw = ''function() Snacks.picker.git_log_line() end'';
      options.desc = "Git Log Line";
    }
    # Grep
    {
      mode = "n";
      key = "<leader>sb";
      action.__raw = ''function() Snacks.picker.lines() end'';
      options.desc = "Buffer Lines";
    }
    {
      mode = "n";
      key = "<leader>sB";
      action.__raw = ''function() Snacks.picker.grep_buffers() end'';
      options.desc = "Grep Open BUffers";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action.__raw = ''function() Snacks.picker.grep() end'';
      options.desc = "Grep";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sw";
      action.__raw = ''function() Snacks.picker.grep_word() end'';
      options.desc = "Visual selection or word";
    }
    # Search
    {
      mode = "n";
      key = ''<leader>s"'';
      action.__raw = ''function() Snacks.picker.registers() end'';
      options.desc = "Registers";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = ''function() Snacks.picker.search_history() end'';
      options.desc = "Search History";
    }
    {
      mode = "n";
      key = "<leader>sc";
      action.__raw = ''function() Snacks.picker.command_history() end'';
      options.desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>sC";
      action.__raw = ''function() Snacks.picker.commands() end'';
      options.desc = "Commands";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action.__raw = ''function() Snacks.picker.diagnostics() end'';
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action.__raw = ''function() Snacks.picker.help() end'';
      options.desc = "Help Pages";
    }
    {
      mode = "n";
      key = "<leader>sj";
      action.__raw = ''function() Snacks.picker.jumps() end'';
      options.desc = "Jumps";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action.__raw = ''function() Snacks.picker.loclist() end'';
      options.desc = "Location List";
    }
    {
      mode = "n";
      key = "<leader>sm";
      action.__raw = ''function() Snacks.picker.marks() end'';
      options.desc = "Marks";
    }
    {
      mode = "n";
      key = "<leader>sM";
      action.__raw = ''function() Snacks.picker.man() end'';
      options.desc = "Man Pages";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action.__raw = ''function() Snacks.picker.qflist() end'';
      options.desc = "Quickfix List";
    }
    {
      mode = "n";
      key = "<leader>sR";
      action.__raw = ''function() Snacks.picker.resume() end'';
      options.desc = "Resume";
    }
    {
      mode = "n";
      key = "<leader>su";
      action.__raw = ''function() Snacks.picker.undo() end'';
      options.desc = "Unod History";
    }
    # LSP
    {
      mode = "n";
      key = "<leader>ss";
      action.__raw = ''function() Snacks.picker.lsp_symbols() end'';
      options.desc = "Lsp Symbols";
    }
    # Others
    {
      mode = "n";
      key = "<leader>z";
      action.__raw = ''function() Snacks.zen() end'';
      options.desc = "Toggle Zen Mode";
    }
    {
      mode = "n";
      key = "<leader>Z";
      action.__raw = ''function() Snacks.zen.zoom() end'';
      options.desc = "Toggle Zoom";
    }
    {
      mode = "n";
      key = "<leader>.";
      action.__raw = ''function() Snacks.scratch() end'';
      options.desc = "Toggle Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>S";
      action.__raw = ''function() Snacks.scratch.select() end'';
      options.desc = "Select Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = ''function() Snacks.bufdelete() end'';
      options.desc = "Delete Buffer";
    }
    {
      mode = "n";
      key = "<leader>bD";
      action.__raw = ''function() Snacks.bufdelete.other() end'';
      options.desc = "Delete Other Buffers";
    }
    {
      mode = "n";
      key = "<leader>cR";
      action.__raw = ''function() Snacks.rename.rename_file() end'';
      options.desc = "Rename File";
    }
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = ''function() Snacks.lazygit() end'';
      options.desc = "Lazygit";
    }
    {
      mode = "n";
      key = "<leader>un";
      action.__raw = ''function() Snacks.notifier.hide() end'';
      options.desc = "Dismiss All Notifications";
    }
  ];
}
