{ pkgs, ... }: {
  plugins = {
    blink-indent.enable = true;
    fff.enable = true;
    flash.enable = true;

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
        postPatch =
          (oldAttrs.postPatch or "")
          # sh
          + ''
            substituteInPlace lua/snacks/image/terminal.lua \
              --replace-fail 'local environments = {' \
              'local environments = {
              { name = "rex", terminal = "rex", supported = true, placeholders = true },'
          '';
        postInstall =
          (oldAttrs.postInstall or "")
          # sh
          + ''
            mkdir $out/after
            mv $out/{queries,after/queries}
          '';
      });
      settings = {
        explorer.enabled = true;
        input.enabled = true;
        picker.enabled = true;
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
        "x"
      ];
      key = "<leader>sr";
      action.__raw = ''
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({ prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil } })
        end
      '';
      options.desc = "[S]earch and [r]eplace";
    }

    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = "function() require('fff').find_files() end";
      options.desc = "[F]ind [f]iles";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = "function() require('fff').live_grep() end";
      options.desc = "[F]ind text with live [g]rep";
    }
    {
      mode = "n";
      key = "<leader>fz";
      action.__raw = "function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end";
      options.desc = "[F]ind text with fu[z]zy grep";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>fw";
      action.__raw = "function() require('fff').live_grep_under_cursor() end";
      options.desc = "[F]ind current [w]ord or selection";
    }

    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action.__raw = "function() require('flash').jump() end";
      options.desc = "Jump to text with Flash";
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
      options.desc = "Jump to a syntax node with Flash";
    }
    {
      mode = "o";
      key = "r";
      action.__raw = "function() require('flash').remote() end";
      options.desc = "Apply operator at a [r]emote location";
    }
    {
      mode = [
        "x"
        "o"
      ];
      key = "R";
      action.__raw = "function() require('flash').treesitter_search() end";
      options.desc = "Search syntax nodes with Flash";
    }
    {
      mode = "c";
      key = "<C-s>";
      action.__raw = "function() require('flash').toggle() end";
      options.desc = "Toggle Flash in command-line search";
    }

    # Picker
    # Top
    {
      mode = "n";
      key = "<leader><space>";
      action.__raw = "function() Snacks.picker.smart() end";
      options.desc = "Open a file or buffer";
    }
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "Open file [e]xplorer";
    }
    # Find
    {
      mode = "n";
      key = "<leader>fm";
      action.__raw = "function() Snacks.picker({ layout = 'select' }) end";
      options.desc = "Open [f]inder [m]enu";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action.__raw = "function() Snacks.picker.projects() end";
      options.desc = "[F]ind [p]rojects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action.__raw = "function() Snacks.picker.recent() end";
      options.desc = "[F]ind [r]ecent files";
    }
    # git: lazygit is Rex's toggle_lazygit float
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = "function() Snacks.picker.git_log_line() end";
      options.desc = "[G]it [l]og for current line";
    }
    # buffer
    {
      mode = "n";
      key = "<leader>bb";
      action.__raw = "function() Snacks.picker.buffers({ layout = 'select' }) end";
      options.desc = "Switch [b]uffers";
    }
    {
      mode = "n";
      key = "<leader>bl";
      action.__raw = "function() Snacks.picker.lines() end";
      options.desc = "Search [l]ines in current [b]uffer";
    }
    {
      mode = "n";
      key = "<leader>bg";
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      options.desc = "[G]rep open [b]uffers";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "[D]elete current [b]uffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action.__raw = "function() Snacks.bufdelete.other() end";
      options.desc = "Delete [o]ther [b]uffers";
    }
    # Search
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = "function() Snacks.picker.search_history() end";
      options.desc = "[S]earch history (/)";
    }
    {
      mode = "n";
      key = "<leader>sc";
      action.__raw = "function() Snacks.picker.command_history() end";
      options.desc = "[S]earch [c]ommand history";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action.__raw = "function() Snacks.picker.diagnostics() end";
      options.desc = "[S]earch [d]iagnostics";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action.__raw = "function() Snacks.picker.help() end";
      options.desc = "[S]earch [h]elp pages";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action.__raw = "function() Snacks.picker.loclist() end";
      options.desc = "[S]earch [l]ocation list";
    }
    {
      mode = "n";
      key = "<leader>sm";
      action.__raw = "function() Snacks.picker.marks() end";
      options.desc = "[S]earch [m]arks";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action.__raw = "function() Snacks.picker.qflist() end";
      options.desc = "[S]earch [q]uickfix list";
    }
    {
      mode = "n";
      key = "<leader>su";
      action.__raw = "function() Snacks.picker.undo() end";
      options.desc = "[S]earch [u]ndo history";
    }
    # LSP
    {
      mode = "n";
      key = "<leader>ss";
      action.__raw = "function() Snacks.picker.lsp_symbols() end";
      options.desc = "[S]earch document [s]ymbols";
    }
    # Others
    {
      mode = "n";
      key = "<leader>cr";
      action.__raw = "function() Snacks.rename.rename_file() end";
      options.desc = "[R]ename file";
    }
  ];
}
