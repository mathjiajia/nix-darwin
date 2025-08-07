{pkgs, ...}: {
  programs.nixvim.plugins = {
    flash.enable = true;
    grug-far.enable = true;
    nvim-surround.enable = true;

    oil = {
      enable = true;
      luaConfig.pre = ''
        function _G.get_oil_winbar()
        	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
        	local dir = require("oil").get_current_dir(bufnr)
        	if dir then
        		return vim.fn.fnamemodify(dir, ":~")
        	else
        		return vim.api.nvim_buf_get_name(0)
        	end
        end

        local detail = false
      '';
      settings = {
        win_options.winbar = "%!v:lua.get_oil_winbar()";
        keymaps.gd.__raw = ''
          {
          	desc = "Toggle file detail view",
          	callback = function()
          		detail = not detail
          		if detail then
          			require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          		else
          			require("oil").set_columns({ "icon" })
          		end
          	end,
          }
        '';
      };
    };

    aerial = {
      enable = true;
      package = pkgs.vimPlugins.aerial-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          oldAttrs.postInstall
            or ""
          + # sh
          ''mv $out/doc/api.md $out/doc/aerial-nvim_api.md'';
      });
      settings = {
        backends = ["lsp" "treesitter" "markdown" "man"];
        layout.default_direction = "prefer_left";
        show_guides = true;
        filter_kind = [
          "Array"
          "Boolean"
          "Class"
          # "Constant"
          "Constructor"
          "Enum"
          "EnumMember"
          "Event"
          "Field"
          "File"
          "Function"
          "Interface"
          "Key"
          "Method"
          "Module"
          "Namespace"
          "Null"
          "Number"
          "Object"
          "Operator"
          # "Package"
          "Property"
          "String"
          "Struct"
          "TypeParameter"
          "Variable"
        ];
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
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<Cmd>Oil<CR>";
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
      mode = "n";
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
