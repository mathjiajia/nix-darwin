{
  programs.nixvim = {
    plugins.neo-tree = {
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

    keymaps = [
      {
        key = "<leader>fe";
        action.__raw = # lua
          "function() require('neo-tree.command').execute({ dir = vim.uv.cwd(), toggle = true }) end";
        options.desc = "Explorer NeoTree (cwd)";
      }
      {
        key = "<leader>ge";
        action.__raw = # lua
          "function() require('neo-tree.command').execute({ source = 'git_status', toggle = true }) end";
        options.desc = "Git Explorer";
      }
      {
        key = "<leader>be";
        action.__raw = # lua
          "function() require('neo-tree.command').execute({ source = 'buffers', toggle = true }) end";
        options.desc = "Buffer Explorer";
      }
    ];
  };
}
