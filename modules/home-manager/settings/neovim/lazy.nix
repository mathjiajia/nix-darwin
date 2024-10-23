{ ... }:
{
  programs.nixvim.plugins = {
    lz-n = {
      enable = true;
      plugins = [
        {
          __unkeyed-1 = "luasnip";
          event = [ "InsertEnter" ];
        }
        {
          __unkeyed-1 = "copilot.lua";
          cmd = [ "Copilot" ];
        }
        {
          __unkeyed-1 = "neo-tree.nvim";
          after = # lua
            ''
              function()
                require("neo-tree").setup()
              end
            '';
          keys = [
            {
              __unkeyed-1 = "<leader>fe";
              __unkeyed-2 = "<CMD>Neotree toggle<CR>";
              desc = "NeoTree toggle";
            }
          ];
        }
        {
          __unkeyed-1 = "fzf-lua";
          cmd = [
            "FzfLua"
          ];
          # keys = [
          #   {
          #     __unkeyed-1 = "<leader>fa";
          #     __unkeyed-2 = "<CMD>Telescope autocommands<CR>";
          #     desc = "Telescope autocommands";
          #   }
          #   {
          #     __unkeyed-1 = "<leader>fb";
          #     __unkeyed-2 = "<CMD>Telescope buffers<CR>";
          #     desc = "Telescope buffers";
          #   }
          # ];
        }
      ];
    };
  };
}
