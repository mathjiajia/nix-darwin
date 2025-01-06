{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      defaultComponentConfigs.indent.withExpanders = true;
      filesystem = {
        bindToCwd = false;
        followCurrentFile.enabled = true;
        useLibuvFileWatcher = true;
      };
      eventHandlers = {
        file_moved =
          # lua
          ''
            function(data) Snacks.rename.on_rename_file(data.source, data.destination) end
          '';
        file_renamed =
          # lua
          ''
            function(data) Snacks.rename.on_rename_file(data.source, data.destination) end
          '';
      };
      extraOptions = {
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
              function(icon, node) icon.text, icon.highlight = MiniIcons.get("lsp", node.extra.kind.name) end
            '';
        };
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
