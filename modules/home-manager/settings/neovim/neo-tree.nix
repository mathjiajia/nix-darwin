{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      # open_files_do_not_replace_types = { "aerial"; "qf"; "terminal"; };
      defaultComponentConfigs = {
        icon.provider =
          #lua
          ''
            function(icon, node)
              local text, hl
              local mini_icons = require("mini.icons")
              if node.type == "file" then -- if it's a file, set the text/hl
                text, hl = mini_icons.get("file", node.name)
              elseif node.type == "directory" then -- get directory icons
                text, hl = mini_icons.get("directory", node.name)
                -- only set the icon text if it is not expanded
                if node:is_expanded() then
                  text = nil
                end
              elseif node.type == "symbol" then
                local kind = vim.tbl_get(node, "extra", "kind", "name")
                if kind then
                  text, hl = mini_icons.get("lsp", kind)
                end
              end

              -- set the icon text/highlight only if it exists
              if text then
                icon.text = text
              end
              if hl then
                icon.highlight = hl
              end
            end
          '';
        indent.withExpanders = true;
      };
      filesystem = {
        bindToCwd = false;
        followCurrentFile.enabled = true;
        useLibuvFileWatcher = true;
        filteredItems = {
          hideDotfiles = false;
          hideGitignored = true;
          hideByName = [".git"];
        };
      };
    };

    keymaps = [
      {
        key = "<leader>fe";
        action.__raw =
          # lua
          ''function() require("neo-tree.command").execute({ dir = vim.uv.cwd(), toggle = true }) end'';
        options.desc = "Explorer NeoTree (cwd)";
      }
      {
        key = "<leader>ge";
        action.__raw =
          # lua
          ''function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end'';
        options.desc = "Git Explorer";
      }
      {
        key = "<leader>be";
        action.__raw =
          # lua
          ''function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end'';
        options.desc = "Buffer Explorer";
      }
    ];
  };
}
