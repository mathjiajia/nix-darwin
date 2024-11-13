{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      defaultComponentConfigs = {
        # icon.provider.__raw =
        #   # lua
        #   ''
        #     function(icon, node)
        #     	local text, hl
        #     	local mini_icons = require "mini.icons"
        #     	if node.type == "file" then
        #     		text, hl = mini_icons.get("file", node.name)
        #     	elseif node.type == "directory" then
        #     		text, hl = mini_icons.get("directory", node.name)
        #     		if node:is_expanded() then text = nil end
        #     	end
        #
        #     	if text then icon.text = text end
        #     	if hl then icon.highlight = hl end
        #     end
        #   '';
        # kind_icon.provider.__raw =
        #   # lua
        #   ''
        #     function(icon, node)
        #     	icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
        #     end
        #   '';
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
