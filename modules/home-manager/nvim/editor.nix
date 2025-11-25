{ lib, pkgs, ... }:
{
  plugins = {
    flash.enable = true;
    nvim-surround.enable = true;

    grug-far = {
      enable = true;
      luaConfig.content = lib.mkForce "";
    };
    blink-indent = {
      enable = true;
      luaConfig.content = lib.mkForce "";
    };
    fff = {
      enable = true;
      luaConfig.content = lib.mkForce "";
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
      settings = {
        explorer.enabled = true;
        input.enabled = true;
        notifier.enabled = true;
        picker.enabled = true;
        styles.lazygit = {
          width = 0;
          height = 0;
        };
      };
    };
  };

  globals = {
    grug-far.icons.fileIconsProvider = "mini.icons";
    fff = {
      layout.prompt_position = "top";
      lazy_sync = true;
      prompt = "   ";
    };
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
      action.__raw = "function() require('fff').find_in_git_root() end";
      options.desc = "[F]ind [G]it Files";
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
      key = "S";
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
      key = "<leader>n";
      action.__raw = "function() Snacks.picker.notifications() end";
      options.desc = "[N]otification History";
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
      key = "<leader>gd";
      action.__raw = "function() Snacks.picker.git_diff() end";
      options.desc = "[G]it [D]iff (Hunks)";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action.__raw = "function() Snacks.picker.git_log_file() end";
      options.desc = "[G]it Log [F]ile";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = "function() Snacks.picker.git_log() end";
      options.desc = "[G]it [L]og";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action.__raw = "function() Snacks.picker.git_log_line() end";
      options.desc = "[G]it Log [L]ine";
    }
    # Grep
    {
      mode = "n";
      key = "<leader>sb";
      action.__raw = "function() Snacks.picker.lines() end";
      options.desc = "[B]uffer Lines";
    }
    {
      mode = "n";
      key = "<leader>sB";
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      options.desc = "Grep Open [B]uffers";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action.__raw = "function() Snacks.picker.grep() end";
      options.desc = "[G]rep";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sw";
      action.__raw = "function() Snacks.picker.grep_word() end";
      options.desc = "Visual selection or [W]ord";
    }
    # Search
    {
      mode = "n";
      key = ''<leader>s"'';
      action.__raw = "function() Snacks.picker.registers() end";
      options.desc = "Registers";
    }
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
      key = "<leader>sC";
      action.__raw = "function() Snacks.picker.commands() end";
      options.desc = "[C]ommands";
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
      key = "<leader>sj";
      action.__raw = "function() Snacks.picker.jumps() end";
      options.desc = "[J]umps";
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
      key = "<leader>sR";
      action.__raw = "function() Snacks.picker.resume() end";
      options.desc = "[R]esume";
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
      key = "<leader>z";
      action.__raw = "function() Snacks.zen() end";
      options.desc = "Toggle [Z]en Mode";
    }
    {
      mode = "n";
      key = "<leader>Z";
      action.__raw = "function() Snacks.zen.zoom() end";
      options.desc = "Toggle [Z]oom";
    }
    {
      mode = "n";
      key = "<leader>.";
      action.__raw = "function() Snacks.scratch() end";
      options.desc = "Toggle Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>S";
      action.__raw = "function() Snacks.scratch.select() end";
      options.desc = "Select [S]cratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "[D]elete [B]uffer";
    }
    {
      mode = "n";
      key = "<leader>bD";
      action.__raw = "function() Snacks.bufdelete.other() end";
      options.desc = "[D]elete Other [B]uffers";
    }
    {
      mode = "n";
      key = "<leader>cr";
      action.__raw = "function() Snacks.rename.rename_file() end";
      options.desc = "[R]ename File";
    }
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = "function() Snacks.lazygit() end";
      options.desc = "Lazy [G]it";
    }
    {
      mode = "n";
      key = "<leader>un";
      action.__raw = "function() Snacks.notifier.hide() end";
      options.desc = "Dismiss All [N]otifications";
    }
  ];
}
