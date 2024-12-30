{pkgs, ...}: {
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      fromLua = [{}];
      settings = {
        update_events = ["TextChanged" "TextChangedI"];
        delete_check_events = "TextChanged";
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
        ext_opts = {
          "__rawKey__require('luasnip.util.types').choiceNode".active.virt_text = [["󱥸" "Special"]];
          "__rawKey__require('luasnip.util.types').insertNode".active.virt_text = [["" "Boolean"]];
        };
      };
    };

    blink-cmp-copilot.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<C-j>" = ["snippet_backward" "fallback"];
          "<C-l>" = ["snippet_forward" "fallback"];
        };
        fuzzy.prebuilt_binaries.download = false;
        signature.window.border = "rounded";
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            window.border = "rounded";
          };
          list.selection = "auto_insert";
          menu = {
            border = "rounded";
            draw = {
              components = {
                kind_icon = {
                  ellipsis = false;
                  text.__raw =
                    # lua
                    ''
                      function(ctx)
                        local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                        return kind_icon .. " "
                      end
                    '';
                  highlight.__raw =
                    # lua
                    ''
                      function(ctx)
                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                        return hl
                      end
                    '';
                };
              };
              columns.__raw =
                # lua
                ''
                  {
                  	{ "label", "label_description", gap = 1 },
                  	{ "kind_icon", "kind" },
                  	{ "source_name" },
                  }
                '';
              treesitter = ["lsp"];
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
          default = ["lsp" "path" "luasnip" "buffer" "ripgrep" "copilot"];
          providers = {
            copilot = {
              async = true;
              module = "blink-cmp-copilot";
              name = "copilot";
              transform_items.__raw =
                # lua
                ''
                  function(_, items)
                    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1
                    CompletionItemKind[kind_idx] = "Copilot"
                    for _, item in ipairs(items) do
                      item.kind = kind_idx
                    end
                    return items
                  end
                '';
            };
            luasnip.opts.show_autosnippets = false;
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
              opts.additional_rg_options = ["--glob=!*.pdf"];
              transform_items.__raw =
                # lua
                ''
                  function(_, items)
                    for _, item in ipairs(items) do
                      item.kind = require("blink.cmp.types").CompletionItemKind.Field
                    end
                    return items
                  end
                '';
            };
          };
        };
      };
    };

    copilot-lua = {
      enable = true;
      panel.enabled = false;
      suggestion.enabled = false;
    };
  };

  programs.nixvim.extraPackages = [pkgs.nodejs];

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
