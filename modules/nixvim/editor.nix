{ pkgs, ... }: {
  plugins = {
    blink-indent.enable = true;
    fff.enable = true;
    flash.enable = true;
    # fugitive.enable = true;

    grug-far = {
      enable = true;
      callSetup = false;
    };
    nvim-surround = {
      enable = true;
      callSetup = false;
    };

    snacks = {
      enable = true;
      package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          # sh
          + ''
            mkdir $out/after
            mv $out/{queries,after/queries}
          '';
      });
      luaConfig.pre = ''
        -- Register a local Rex profile unless Snacks already provides one.
        local envs = require("snacks.image.terminal").envs()
        local has_rex = vim.iter(envs):any(function(env)
          return env.name == "rex"
        end)
        if not has_rex then
          table.insert(envs, 1, {
            name = "rex",
            terminal = "rex",
            supported = true,
            placeholders = true,
          })
        end
      '';
      settings = {
        explorer.enabled = true;
        input.enabled = true;
        picker.enabled = true;
        styles.lazygit = {
          width = 0;
          height = 0;
        };
        words.enabled = true;
      };
    };
  };

  globals.fff = {
    lazy_sync = true;
    layout.prompt_position = "top";
  };

  keymaps = [
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
      options.desc = "[S]earch and [R]eplace";
    }

    {
      mode = "n";
      key = "<leader>ff";
      action = "<Cmd>FFFFind<CR>";
      options.desc = "[F]ile [F]inder";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = "function() require('fff').live_grep() end";
      options.desc = "Live [G]rep";
    }
    {
      mode = "n";
      key = "<leader>fz";
      action.__raw = "function() require('fff').live_grep({ grep = { mode = { 'fuzzy', 'plain' } } }) end";
      options.desc = "Live Fuzzy [G]rep";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>fw";
      action.__raw = "function() require('fff').live_grep_under_cursor() end";
      options.desc = "Search current word / selection";
    }

    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action.__raw = "function() require('flash').jump() end";
      options.desc = "Flash";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      # Leave visual S and gS to nvim-surround.
      key = "gs";
      action.__raw = "function() require('flash').treesitter() end";
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o";
      key = "r";
      action.__raw = "function() require('flash').remote() end";
      options.desc = "[R]emote Flash";
    }
    {
      mode = [
        "x"
        "o"
      ];
      key = "R";
      action.__raw = "function() require('flash').treesitter_search() end";
      options.desc = "Treesitter Search";
    }
    {
      mode = "c";
      key = "<C-s>";
      action.__raw = "function() require('flash').toggle() end";
      options.desc = "Toggle Flash Search";
    }

    # Picker
    # Top
    {
      mode = "n";
      key = "<leader><space>";
      action.__raw = "function() Snacks.picker.smart() end";
      options.desc = "Smart Open";
    }
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "[E]xplorer";
    }
    # Find
    {
      mode = "n";
      key = "<leader>fb";
      action.__raw = "function() Snacks.picker.buffers({ layout = 'select' }) end";
      options.desc = "[F]ind [B]uffers";
    }
    {
      mode = "n";
      key = "<leader>fm";
      action.__raw = "function() Snacks.picker({ layout = 'select' }) end";
      options.desc = "[F]ind [M]eta";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action.__raw = "function() Snacks.picker.projects() end";
      options.desc = "[F]ind [P]rojects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action.__raw = "function() Snacks.picker.recent() end";
      options.desc = "[F]ind [R]ecent";
    }
    # git
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = "function() Snacks.lazygit() end";
      options.desc = "Lazy [G]it";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = "function() Snacks.picker.git_log_line() end";
      options.desc = "[G]it Log [L]ine";
    }
    # buffer
    {
      mode = "n";
      key = "<leader>bl";
      action.__raw = "function() Snacks.picker.lines() end";
      options.desc = "[B]uffer [L]ines";
    }
    {
      mode = "n";
      key = "<leader>bg";
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      options.desc = "[G]rep Open [B]uffers";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "[D]elete [B]uffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action.__raw = "function() Snacks.bufdelete.other() end";
      options.desc = "[D]elete [O]ther Buffers";
    }
    # Search
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = "function() Snacks.picker.search_history() end";
      options.desc = "Search History";
    }
    {
      mode = "n";
      key = "<leader>sc";
      action.__raw = "function() Snacks.picker.command_history() end";
      options.desc = "[C]ommand History";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action.__raw = "function() Snacks.picker.diagnostics() end";
      options.desc = "[D]iagnostics";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action.__raw = "function() Snacks.picker.help() end";
      options.desc = "[H]elp Pages";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action.__raw = "function() Snacks.picker.loclist() end";
      options.desc = "[L]ocation List";
    }
    {
      mode = "n";
      key = "<leader>sm";
      action.__raw = "function() Snacks.picker.marks() end";
      options.desc = "[M]arks";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action.__raw = "function() Snacks.picker.qflist() end";
      options.desc = "[Q]uickfix List";
    }
    {
      mode = "n";
      key = "<leader>su";
      action.__raw = "function() Snacks.picker.undo() end";
      options.desc = "[U]ndo History";
    }
    # LSP
    {
      mode = "n";
      key = "<leader>ss";
      action.__raw = "function() Snacks.picker.lsp_symbols() end";
      options.desc = "Lsp [S]ymbols";
    }
    # Others
    {
      mode = "n";
      key = "<leader>cr";
      action.__raw = "function() Snacks.rename.rename_file() end";
      options.desc = "[R]ename File";
    }
  ];
}
