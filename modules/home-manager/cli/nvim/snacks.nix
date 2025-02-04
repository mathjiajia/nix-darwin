{pkgs, ...}: {
  programs.nixvim.plugins.snacks = {
    enable = true;
    package = pkgs.vimPlugins.snacks-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        oldAttrs.postInstall
        or ""
        + # sh
        ''mkdir --parents $out/after/; mv $out/queries/ $out/after/queries/'';
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "snacks.nvim";
        rev = "master";
        sha256 = "fj3cLaUK9WxjbqwtKH7yurfDf4WFKOyhY9c9XbPFMZ4=";
      };
      nvimSkipModule = oldAttrs.nvimSkipModule ++ ["snacks.picker.core.list"];
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
      explorer.replace_netrw = true;
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
      picker = {
        enabled = true;
        win.input.keys = {
          "<M-c>" = {
            __unkeyed-1 = "toggle_cwd";
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
          toggle_cwd.__raw =
            # lua
            ''
              function(p)
              	local root = require("util.root")({ buf = p.input.filter.current_buf })
              	local cwd = vim.fs.normalize(vim.uv.cwd() or ".")
              	local current = p:cwd()
              	p:set_cwd(current == root and cwd or root)
              	p:find()
              end
            '';
        };
        ui_select = true;
      };
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
      key = "<leader>gg";
      action.__raw = ''function() Snacks.lazygit({ cwd = require("util.root").git() }) end'';
      options.desc = "Lazygit (Root Dir)";
    }
    {
      key = "<leader>gG";
      action.__raw = ''function() Snacks.lazygit() end'';
      options.desc = "Lazygit (cwd)";
    }
    {
      key = "<leader>gf";
      action.__raw = ''function() Snacks.picker.git_log_file() end'';
      options.desc = "Git Current File History";
    }
    {
      key = "<leader>gl";
      action.__raw = ''function() Snacks.picker.git_log({ cwd = require("util.root").git() }) end'';
      options.desc = "Git Log";
    }
    {
      key = "<leader>gL";
      action.__raw = ''function() Snacks.picker.git_log() end'';
      options.desc = "Git Log (cwd)";
    }

    {
      key = "<leader>cR";
      action.__raw = ''function() Snacks.rename.rename_file() end'';
      options.desc = "Rename File";
    }

    # Terminal
    {
      key = "<C-/>";
      action.__raw = ''function() Snacks.terminal(nil, { cwd = require("util.root")() }) end'';
      options.desc = "Terminal (Root Dir)";
    }
    {
      mode = "t";
      key = "<C-/>";
      action = ''<Cmd>close<CR>'';
      options.desc = "Hide Terminal";
    }
    {
      key = "<leader>fT";
      action.__raw = ''function() Snacks.terminal() end'';
      options.desc = "Terminal (cwd)";
    }

    # Picker
    # Find
    {
      key = "<leader><space>";
      action.__raw = ''function() Snacks.picker.smart() end'';
      options.desc = "Smart Open";
    }
    {
      key = "<leader>n";
      action.__raw = ''function() Snacks.picker.notifications() end'';
      options.desc = "Notification History";
    }

    {
      key = "<leader>fb";
      action.__raw = ''function() Snacks.picker.buffers({ layout = "select" }) end'';
      options.desc = "Buffers";
    }
    {
      key = "<leader>fe";
      action.__raw = ''function() Snacks.explorer({ cwd = require("util.root")() }) end'';
      options.desc = "File Explorer (Root Dir)";
    }
    {
      key = "<leader>fE";
      action.__raw = ''function() Snacks.explorer() end'';
      options.desc = "File Explorer";
    }
    {
      key = "<leader>ff";
      action.__raw = ''function() Snacks.picker.files({ cwd = require("util.root")() }) end'';
      options.desc = "Find Files (Root Dir)";
    }
    {
      key = "<leader>fF";
      action.__raw = ''function() Snacks.picker.files() end'';
      options.desc = "Find Files (cwd)";
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

    # Grep
    {
      key = "<leader>sb";
      action.__raw = ''function() Snacks.picker.lines() end'';
      options.desc = "Buffer Lines";
    }
    {
      key = "<leader>sg";
      action.__raw = ''function() Snacks.picker.grep({ dirs = { require("util.root")() } }) end'';
      options.desc = "Grep (Root Dir)";
    }
    {
      key = "<leader>sG";
      action.__raw = ''function() Snacks.picker.grep() end'';
      options.desc = "Grep (cwd)";
    }
    {
      mode = ["n" "x"];
      key = "<leader>sw";
      action.__raw = ''function() Snacks.picker.grep_word({ dirs = { require("util.root")() } }) end'';
      options.desc = "Word (Root Dir)";
    }
    {
      mode = ["n" "x"];
      key = "<leader>sW";
      action.__raw = ''function() Snacks.picker.grep_word() end'';
      options.desc = "Word (cwd)";
    }

    # Search
    {
      key = ''<leader>s"'';
      action.__raw = ''function() Snacks.picker.registers() end'';
      options.desc = "Registers";
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
  ];
}
