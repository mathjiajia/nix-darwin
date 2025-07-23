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
        preset = {
          header = ''
            ██████████████████████████████████████████████████
            █████ ████████████████████████████████████████
            ████   ███  ████████████████  █ ███████████
            ███     █     █     ██  ████ █ ███
            ██  █       ██ ██    █        ██
            ██  ███   █   ██ ██ █   █  █ █  ██
            ███████ ██    █    ███ █  █████ ██
            ██████████████████████████████████████████████████'';
          keys = [
            {
              key = "f";
              action = ":FFFFind";
              hidden = true;
            }
            {
              key = "n";
              action = ":ene | startinsert";
              hidden = true;
            }
            {
              key = "g";
              action = ":lua Snacks.picker.grep()";
              hidden = true;
            }
            {
              key = "r";
              action = ":lua Snacks.picker.recent()";
              hidden = true;
            }
            {
              key = "q";
              action = ":qa";
              hidden = true;
            }
          ];
        };
        sections = [
          {section = "header";}
          {section = "keys";}
          {
            padding = 2;
            align = "center";
            text = [
              {
                __unkeyed-1 = " [f]ile  ";
                hl = "BlinkPairsBlue";
              }
              {
                __unkeyed-1 = " [n]ew  ";
                hl = "BlinkPairsYellow";
              }
              {
                __unkeyed-1 = " [g]rep  ";
                hl = "BlinkPairsGreen";
              }
              {
                __unkeyed-1 = " [r]ecent  ";
                hl = "BlinkPairsTeal";
              }
              {
                __unkeyed-1 = " [q]uit";
                hl = "BlinkPairsPurple";
              }
            ];
          }
          {
            icon = " ";
            title = "Recent Files";
            section = "recent_files";
            indent = 2;
            padding = 1;
          }
          {
            icon = " ";
            title = "Projects";
            section = "projects";
            indent = 2;
            padding = 1;
          }
        ];
      };
      image = {
        enabled.__raw = ''not vim.g.neovide'';
        math.enabled = false;
      };
      indent.scope.hl = [
        "BlinkPairsBlue"
        "BlinkPairsYellow"
        "BlinkPairsGreen"
        "BlinkPairsTeal"
        "BlinkPairsMagenta"
        "BlinkPairsPurple"
        "BlinkPairsOrange"
      ];
      input.enabled = true;
      notifier.enabled = true;
      picker = {
        win.input.keys = {
          "<M-d>" = {
            __unkeyed-1 = "toggle_hidden";
            mode = ["n" "i"];
          };
          "<M-s>" = {
            __unkeyed-1 = "flash";
            mode = ["n" "i"];
          };
          s = ["flash"];
        };
        action = {
          flash.__raw =
            # lua
            ''
              function(picker)
              	require("flash").jump({
              		pattern = "^",
              		label = { after = { 0, 0 } },
              		search = {
              			mode = "search",
              			exclude = {
              				function(win)
              					return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
              				end,
              			},
              		},
              		action = function(match)
              			local idx = picker.list:row2idx(match.pos[1])
              			picker.list:_move(idx, true, true)
              		end,
              	})
              end
            '';
        };
      };
      # scroll.enabled.__raw = ''not vim.g.neovide'';
      scope.enabled = true;
      styles = {
        lazygit = {
          width = 0;
          height = 0;
        };
        notification.wo.wrap = true;
      };
    };
  };

  programs.nixvim.keymaps = [
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
    # {
    #   mode = "n";
    #   key = "<leader>ff";
    #   action.__raw = ''function() Snacks.picker.files() end'';
    #   options.desc = "Find Files";
    # }
    # {
    #   mode = "n";
    #   key = "<leader>fg";
    #   action.__raw = ''function() Snacks.picker.git_files() end'';
    #   options.desc = "Find Git Files";
    # }
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
      mode = ["n" "x"];
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
