{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.blink-pairs ];
  extraConfigLua = ''
    require("blink.pairs").setup({
    	highlights = {
    		groups = {
    			"BlinkPairsOrange",
    			"BlinkPairsPurple",
    			"BlinkPairsBlue",
    			"BlinkPairsCyan",
    			"BlinkPairsYellow",
    			"BlinkPairsGreen",
    		},
    	},
    })
  '';

  plugins = {
    luasnip = {
      enable = true;
      fromLua = [ { } ];
      settings = {
        update_events = [
          "TextChanged"
          "TextChangedI"
        ];
        delete_check_events = "TextChanged";
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
        ext_opts = {
          "__rawKey__require('luasnip.util.types').choiceNode".active.virt_text = [
            [
              "󱥸"
              "Special"
            ]
          ];
          "__rawKey__require('luasnip.util.types').insertNode".active.virt_text = [
            [
              ""
              "Boolean"
            ]
          ];
        };
      };
    };

    # copilot-lua.enable = false;
    # blink-copilot.enable = true;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      luaConfig.pre = ''
        local source_dedup_priority = { "lsp", "path", "snippets", "buffer", "ripgrep" }
        local show_orig = require("blink.cmp.completion.list").show
        require("blink.cmp.completion.list").show = function(ctx, items_by_source)
        	local seen = {}
        	for _, source in ipairs(source_dedup_priority) do
        		if items_by_source[source] then
        			items_by_source[source] = vim.tbl_filter(function(item)
        				local did_seen = seen[item.label]
        				seen[item.label] = true
        				return not did_seen
        			end, items_by_source[source])
        		end
        	end
        	return show_orig(ctx, items_by_source)
        end
      '';
      settings = {
        completion = {
          documentation.auto_show = true;
          list.max_items = 20;
          menu.draw.treesitter = [ "lsp" ];
        };
        snippets.preset = "luasnip";
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "ripgrep"
            # "copilot"
          ];
          providers = {
            snippets.opts.show_autosnippets = false;
            # copilot = {
            #   async = true;
            #   module = "blink-copilot";
            #   name = "Copilot";
            # };
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
            };
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [
        "i"
        "s"
      ];
      key = "<C-;>";
      action.__raw = "function() if require('luasnip').choice_active() then require('luasnip').change_choice(1) end end";
      options.silent = true;
      options.desc = "Change Choice";
    }
  ];
}
