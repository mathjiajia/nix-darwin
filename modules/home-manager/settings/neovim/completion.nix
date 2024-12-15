{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      fromLua = [{lazyLoad = true;}];
      settings = {
        update_events = "TextChanged,TextChangedI";
        delete_check_events = "TextChanged";
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
        ext_opts.__raw =
          # lua
          ''
            {
              [require("luasnip.util.types").insertNode] = { active = { virt_text = { { "", "Boolean" } } } },
              [require("luasnip.util.types").choiceNode] = { active = { virt_text = { { "󱥸", "Special" } } } },
            }
          '';
      };
    };

    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-j>" = ["snippet_backward" "fallback"];
          "<C-l>" = ["snippet_forward" "fallback"];
        };
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            window.border = "rounded";
          };
          menu = {
            border = "rounded";
            draw = {
              columns.__raw =
                # lua
                ''
                  {
                  	{ "label", "label_description", gap = 1 },
                  	{ "kind_icon", "kind" },
                  	{ "source_name" },
                  }
                '';
              # treesitter = ["lsp"];
              treesitter = true;
            };
          };
        };
        snippets = {
          expand.__raw =
            # lua
            ''
              function(snippet) require("luasnip").lsp_expand(snippet) end
            '';
          active.__raw =
            # lua
            ''
              function(filter)
                if filter and filter.direction then
                  return require("luasnip").jumpable(filter.direction)
                end
                return require("luasnip").in_snippet()
              end
            '';
          jump.__raw =
            # lua
            ''
              function(direction) require("luasnip").jump(direction) end
            '';
        };
        sources = {
          completion.enabled_providers = ["lsp" "path" "luasnip" "buffer" "ripgrep" "copilot"];
          # default = ["lsp" "path" "luasnip" "buffer" "ripgrep" "copilot"];
          providers = {
            copilot = {
              module = "blink-cmp-copilot";
              name = "copilot";
            };
            luasnip.opts.show_autosnippets = false;
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
            };
          };
        };
        appearance.kind_icons = {
          Text = " ";
          Method = " ";
          Function = " ";
          Constructor = " ";
          Field = " ";
          Variable = " ";
          Class = " ";
          Interface = " ";
          Module = " ";
          Property = " ";
          Unit = " ";
          Value = " ";
          Enum = " ";
          Keyword = " ";
          Snippet = " ";
          Color = " ";
          File = " ";
          Reference = " ";
          Folder = " ";
          EnumMember = " ";
          Constant = " ";
          Struct = " ";
          Event = " ";
          Operator = " ";
          TypeParameter = " ";
        };
      };
    };

    copilot-lua = {
      enable = true;
      panel.enabled = false;
      suggestion.enabled = false;
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "<C-k>";
      action.__raw =
        # lua
        ''
          function()
          	if require("luasnip").expandable() then require("luasnip").expand() end
          end
        '';
      options.desc = "LuaSnip Expand";
    }
    {
      mode = ["i" "s"];
      key = "<C-;>";
      action.__raw =
        # lua
        ''
          function()
          	if require("luasnip").choice_active() then require("luasnip").change_choice(1) end
          end
        '';
      options.desc = "LuaSnip Next Choice";
    }
  ];
}
