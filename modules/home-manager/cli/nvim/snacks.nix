{pkgs, ...}: {
  programs.nixvim.plugins.snacks = {
    enable = true;
    package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        oldAttrs.postInstall
        or ""
        + # sh
        ''mkdir --parents $out/after/; mv $out/queries/ $out/after/queries/'';
    });
    settings = {
      dashboard = {
        enabled = true;
        preset = {
          header = ''
            ██████████████████████████████████████████████████
            █████ ████████████████████████████████████████
            ████   ███  ████████████████  █ ███████████
            ███     █     █     ██  ████ █ ███
            ██  █       ██ ██    █        ██
            ██  ███   █   ██ ██ █   █  █ █  ██
            ███████ ██    █    ███ █  █████ ██
            ██████████████████████████████████████████████████
          '';
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.picker.files()";
            }
            {
              icon = " ";
              key = "n";
              desc = "New File";
              action = ":ene | startinsert";
            }
            {
              icon = " ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.picker.grep()";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.picker.recent()";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };
        formats.key.__raw =
          # lua
          ''
            function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end
          '';
        sections = [
          {section = "header";}
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
          {
            pane = 2;
            icon = " ";
            title = "Recent Files";
            section = "recent_files";
            indent = 2;
            padding = 1;
          }
          {
            pane = 2;
            icon = " ";
            title = "Projects";
            section = "projects";
            indent = 2;
            padding = 1;
          }
          {
            pane = 2;
            icon = " ";
            title = "Git Status";
            section = "terminal";
            enabled.__raw = ''function() return Snacks.git.get_root() ~= nil end'';
            cmd = "git status --short --branch --renames";
            height = 5;
            padding = 1;
            ttl = 5 * 60;
            indent = 2;
          }
        ];
      };
      indent = {
        enabled = true;
        scope.hl = [
          "RainbowDelimiterRed"
          "RainbowDelimiterYellow"
          "RainbowDelimiterBlue"
          "RainbowDelimiterOrange"
          "RainbowDelimiterGreen"
          "RainbowDelimiterViolet"
          "RainbowDelimiterCyan"
        ];
      };
      input.enabled = true;
      notifier.enabled = true;
      picker.ui_select = true;
      scroll.enabled.__raw = ''not vim.g.neovide'';
      scope.enabled = true;
      terminal.win.wo.winbar = "";
      words.enabled = true;
      styles = {
        lazygit = {
          width = 0;
          height = 0;
        };
        notification.wo.wrap = true;
        terminal.height = 12;
      };
    };
    luaConfig.post =
      # lua
      ''
        Snacks.toggle.zen():map("<leader>z")
        Snacks.toggle.zoom():map("<leader>Z")
      '';
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>.";
      action.__raw = ''function() Snacks.scratch() end'';
      options.desc = "Toggle Scratch Buffer";
    }
    {
      key = "<leader>S";
      action.__raw = ''function() Snacks.scratch.select() end'';
      options.desc = "Select Scratch Buffer";
    }

    {
      key = "<leader>n";
      action.__raw = ''function() Snacks.notifier.show_history() end'';
      options.desc = "Notification History";
    }
    {
      key = "<leader>un";
      action.__raw = ''function() Snacks.notifier.hide() end'';
      options.desc = "Dismiss All Notifications";
    }

    {
      key = "<leader>bd";
      action.__raw = ''function() Snacks.bufdelete() end'';
      options.desc = "Delete Buffer";
    }
    {
      key = "<leader>bD";
      action.__raw = ''function() Snacks.bufdelete.other() end'';
      options.desc = "Delete Other Buffers";
    }

    {
      key = "<leader>gf";
      action.__raw = ''function() Snacks.picker.git_log_file() end'';
      options.desc = "Git Current File History";
    }
    {
      key = "<leader>gg";
      action.__raw = ''function() Snacks.lazygit() end'';
      options.desc = "Lazygit";
    }

    {
      key = "<leader>cR";
      action.__raw = ''function() Snacks.rename.rename_file() end'';
      options.desc = "Rename File";
    }

    {
      mode = ["n" "t"];
      key = "<C-/>";
      action.__raw = ''function() Snacks.terminal() end'';
      options.desc = "Toggle Terminal";
    }

    {
      key = "<leader><space>";
      action.__raw = ''function() Snacks.picker.files({ cwd = vim.fs.root(0, ".git") }) end'';
      options.desc = "Find Files";
    }
    {
      key = "<leader>fb";
      action.__raw = ''function() Snacks.picker.buffers({ layout = "select" }) end'';
      options.desc = "Buffers";
    }
    {
      key = "<leader>ff";
      action.__raw = ''function() Snacks.picker.files() end'';
      options.desc = "Find Files";
    }
    {
      key = "<leader>fg";
      action.__raw = ''function() Snacks.picker.git_files() end'';
      options.desc = "Find Files (git-files)";
    }
    {
      key = "<leader>fm";
      action.__raw = ''function() Snacks.picker({ layout = "select" }) end'';
      options.desc = "Snacks Picker";
    }
    {
      key = "<leader>fp";
      action.__raw = ''function() Snacks.picker.projects() end'';
      options.desc = "Projects";
    }
    {
      key = "<leader>fr";
      action.__raw = ''function() Snacks.picker.recent() end'';
      options.desc = "Recent";
    }
    {
      key = ''<leader>s"'';
      action.__raw = ''function() Snacks.picker.registers() end'';
      options.desc = "Registers";
    }
    {
      key = "<leader>sb";
      action.__raw = ''function() Snacks.picker.lines() end'';
      options.desc = "Buffer Lines";
    }
    {
      key = "<leader>sc";
      action.__raw = ''function() Snacks.picker.command_history() end'';
      options.desc = "Command History";
    }
    {
      key = "<leader>sC";
      action.__raw = ''function() Snacks.picker.commands() end'';
      options.desc = "Commands";
    }
    {
      key = "<leader>sd";
      action.__raw = ''function() Snacks.picker.diagnostics() end'';
      options.desc = "Diagnostics";
    }
    {
      key = "<leader>sg";
      action.__raw = ''function() Snacks.picker.grep() end'';
      options.desc = "Grep";
    }
    {
      key = "<leader>sh";
      action.__raw = ''function() Snacks.picker.help() end'';
      options.desc = "Help Pages";
    }
    {
      key = "<leader>sj";
      action.__raw = ''function() Snacks.picker.jumps() end'';
      options.desc = "Jumps";
    }
    {
      key = "<leader>sl";
      action.__raw = ''function() Snacks.picker.loclist() end'';
      options.desc = "Location List";
    }
    {
      key = "<leader>sM";
      action.__raw = ''function() Snacks.picker.man() end'';
      options.desc = "Man Pages";
    }
    {
      key = "<leader>sm";
      action.__raw = ''function() Snacks.picker.marks() end'';
      options.desc = "Marks";
    }
    {
      key = "<leader>sR";
      action.__raw = ''function() Snacks.picker.resume() end'';
      options.desc = "Resume";
    }
    {
      key = "<leader>sq";
      action.__raw = ''function() Snacks.picker.qflist() end'';
      options.desc = "Quickfix List";
    }
    {
      key = "<leader>ss";
      action.__raw = ''function() Snacks.picker.lsp_symbols() end'';
      options.desc = "Lsp Symbols";
    }
    {
      mode = ["n" "x"];
      key = "<leader>sw";
      action.__raw = ''function() Snacks.picker.grep_word() end'';
      options.desc = "Grep Word";
    }
  ];
}
