{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      # lazyLoad.settings = {
      #   cmd = "Neotree";
      #   keys = [
      #     {
      #       __unkeyed-1 = "<leader>fe";
      #       __unkeyed-2 = "<Cmd>Neotree toggle<CR>";
      #       desc = "Explorer NeoTree (cwd)";
      #     }
      #     {
      #       __unkeyed-1 = "<leader>ge";
      #       __unkeyed-2 = "<Cmd>Neotree toggle git_status<CR>";
      #       desc = "Git Explorer";
      #     }
      #     {
      #       __unkeyed-1 = "<leader>be";
      #       __unkeyed-2 = "<Cmd>Neotree toggle buffers<CR>";
      #       desc = "Buffer Explorer";
      #     }
      #   ];
      # };
      defaultComponentConfigs.indent.withExpanders = true;
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
      extraOptions = {
        open_files_do_not_replace_types = ["qf" "terminal"];
        default_component_configs = {
          icon.provider.__raw =
            # lua
            ''
              function(icon, node)
                local text, hl
                if node.type == "file" then
                  text, hl = MiniIcons.get("file", node.name)
                elseif node.type == "directory" and (not node:is_expanded()) then
                  text, hl = MiniIcons.get("directory", node.name)
                end

                if text then icon.text = text end

                if hl then icon.highlight = hl end
              end
            '';
          kind_icon.provider.__raw =
            # lua
            ''
              function(icon, node)
                icon.text, icon.highlight = MiniIcons.get("lsp", node.extra.kind.name)
              end
            '';
        };
        event_handlers.__raw =
          # lua
          ''
            {
              {
                event = require("neo-tree.events").FILE_MOVED,
                handler = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end
              },
              {
                event = require("neo-tree.events").FILE_RENAMED,
                handler = function(data) Snacks.rename.on_rename_file(data.source, data.destination) end
              },
            }
          '';
      };
    };

    keymaps = [
      {
        key = "<leader>fe";
        action = "<Cmd>Neotree toggle<CR>";
        options.desc = "Explorer NeoTree (cwd)";
      }
      {
        key = "<leader>ge";
        action = "<Cmd>Neotree toggle git_status<CR>";
        options.desc = "Git Explorer";
      }
      {
        key = "<leader>be";
        action = "<Cmd>Neotree toggle buffers<CR>";
        options.desc = "Buffer Explorer";
      }
    ];
  };
}
