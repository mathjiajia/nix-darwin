{ ... }:
{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    settings = {
      update_events = "TextChanged,TextChangedI";
      delete_check_events = "TextChanged";
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
      ext_opts.__raw = ''
        {
          [require("luasnip.util.types").insertNode] = { active = { virt_text = { { "", "Boolean" } } } },
          [require("luasnip.util.types").choiceNode] = { active = { virt_text = { { "󱥸", "Special" } } } },
        }
      '';
    };
  };

  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    cmdline = {
      "/" = {
        mapping = {
          __raw = "cmp.mapping.preset.cmdline()";
        };
        sources = [
          {
            name = "buffer";
          }
        ];
      };
      "?" = {
        mapping = {
          __raw = "cmp.mapping.preset.cmdline()";
        };
        sources = [
          {
            name = "buffer";
          }
        ];
      };
      ":" = {
        mapping = {
          __raw = "cmp.mapping.preset.cmdline()";
        };
        sources = [
          {
            name = "async_path";
          }
          {
            name = "cmdline";
          }
        ];
      };
    };
    settings = {
      formatting = {
        fields = [
          "abbr"
          "menu"
          "kind"
        ];
        format = ''
          function(entry, item)
            local maxwidth = 30
            local icon = require("mini.icons").get("lsp", item.kind)

            if vim.fn.strchars(item.abbr) > maxwidth then
              item.abbr = vim.fn.strcharpart(item.abbr, 0, maxwidth) .. "…"
            end
            item.menu = ({
              buffer = "[Buffer]",
              cmdline = "[Cmd]",
              nvim_lsp = "[LSP]",
              lazydev = "[Lazy]",
              luasnip = "[Snip]",
              neorg = "[Norg]",
              async_path = "[Path]",
              rg = "[RG]",
            })[entry.source.name]
            item.kind = icon .. " " .. item.kind
            return item
          end
        '';
      };
      mapping = {
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
      };
      matching.disallow_prefix_unmatching = true;
      snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';
      sources = [
        {
          name = "lazydev";
          group_index = 0;
        }
        {
          name = "nvim_lsp";
          group_index = 1;
        }
        {
          name = "luasnip";
          option.show_autosnippets = true;
          group_index = 1;
        }
        {
          name = "async_path";
          group_index = 1;
        }

        {
          name = "copilot";
          max_item_count = 2;
          group_index = 2;
        }
        {
          name = "buffer";
          group_index = 2;
        }
        # { name = "neorg"; }

        {
          name = "rg";
          keyword_length = 2;
          group_index = 3;
        }
      ];
      window = {
        completion = {
          border = "rounded";
          col_offset = -1;
        };
        documentation = {
          border = "rounded";
        };
      };
    };
  };
  programs.nixvim.plugins.copilot-lua = {
    enable = true;
    panel.enabled = false;
    suggestion.enabled = false;
  };
}
