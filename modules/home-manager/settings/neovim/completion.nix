{ pkgs, ... }:
{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    fromLua = [
      {
        lazyLoad = true;
        paths = "luasnippets";
      }
    ];
    settings = {
      update_events = "TextChanged,TextChangedI";
      delete_check_events = "TextChanged";
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
      ext_opts.__raw = # lua
        ''
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
        format = # lua
          ''
            function(entry, vim_item)
              local maxwidth = 30
              local icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
                Copilot = "",
              }
              
              if vim.fn.strchars(vim_item.abbr) > maxwidth then
                vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, maxwidth) .. "…"
              end

              vim_item.kind = icons[vim_item.kind]
              vim_item.menu = ({
                async_path = "[Path]",
                buffer = "[Buf]",
                cmdline = "[Cmd]",
                copilot = "[GHC]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                -- neorg = "[Norg]",
                rg = "[RG]",
              })[entry.source.name]
              return vim_item
            end
          '';
      };
      mapping = {
        __raw = ''
          cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          })
        '';
      };
      matching.disallow_prefix_unmatching = true;
      snippet.expand =
        # lua
        ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
      sources = [
        {
          name = "nvim_lsp";
          group_index = 1;
        }
        {
          name = "luasnip";
          group_index = 1;
          option.show_autosnippets = true;
        }
        {
          name = "async_path";
          group_index = 1;
        }

        {
          name = "copilot";
          group_index = 2;
          max_item_count = 2;
        }
        # {
        #   name = "neorg";
        #   group_index = 2;
        # }
        {
          name = "buffer";
          group_index = 2;
        }

        {
          name = "rg";
          group_index = 3;
          keyword_length = 2;
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
