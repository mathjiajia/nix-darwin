{ ... }:
{
  programs.nixvim.plugins = {
    fzf-lua = {
      enable = true;
      keymaps = {
        "<leader><space>" = {
          action = "files";
          options.desc = "Find Files (current)";
        };
        "<leader>fb" = {
          action = "buffers";
          options.desc = "Buffers";
        };
        "<leader>fc" = {
          action = "files";
          options.desc = "Find Config File";
        };
        "<leader>ff" = {
          action = "files";
          options.desc = "Find Files (cwd)";
        };
        "<leader>fg" = {
          action = "git_files";
          options.desc = "Find Git Files";
        };
        "<leader>fl" = {
          action = "lsp_finder";
          options.desc = "Lsp Finder";
        };
        "<leader>fo" = {
          action = "oldfiles";
          options.desc = "Old Files";
        };
        "<leader>sb" = {
          action = "blines";
          options.desc = "Search Current Buffer Lines";
        };
        "<leader>sg" = {
          action = "live_grep";
          options.desc = "Live Grep";
        };
        "<leader>sh" = {
          action = "helptags";
          options.desc = "Help Tags";
        };
        "<leader>sw" = {
          action = "grep_cword";
          options.desc = "Search Word Under Cursor";
        };
        # ["<leader>sw"] = {
        #   action = "grep_visual";
        #   mode = "v";
        #   options.desc = "Search Visual Selection";
        # };
      };
      settings = {
        grep.RIPGREP_CONFIG_PATH.__raw = ''vim.env.RIPGREP_CONFIG_PATH'';
        defaults = {
          file_icons = "mini";
          formatter = "path.dirname_first";
        };
      };
    };
    neo-tree = {
      enable = true;
      # open_files_do_not_replace_types = { "aerial"; "qf"; "terminal"; };
      defaultComponentConfigs.indent.withExpanders = true;
      filesystem = {
        bindToCwd = false;
        followCurrentFile.enabled = true;
        useLibuvFileWatcher = true;
        filteredItems = {
          hideDotfiles = false;
          hideGitignored = true;
          hideByName = [ ".git" ];
        };
      };
    };

    nvim-surround.enable = true;
    flash.enable = true;
  };
}
