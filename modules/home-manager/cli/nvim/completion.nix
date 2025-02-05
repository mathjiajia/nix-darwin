{pkgs, ...}: {
  programs.nixvim.extraPackages = [pkgs.nodejs];

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

    blink-copilot.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          "<Tab>" = ["fallback"];
          "<S-Tab>" = ["fallback"];
          "<C-j>" = ["snippet_backward" "fallback"];
          "<C-l>" = ["snippet_forward" "fallback"];
        };
        signature.window.border = "rounded";
        appearance = {
          nerd_font_variant = "normal";
          kind_icons = {
            Copilot = "";

            Text = "";
            Method = "";
            Function = "";
            Constructor = "";

            Field = "";
            Variable = "";
            Property = "";

            Class = "";
            Interface = "";
            Struct = "";
            Module = "";

            Unit = "";
            Value = "";
            Enum = "";
            Enummember = "";

            Keyword = "";
            Constant = "";

            Snippet = "";
            Color = "";
            File = "";
            Reference = "";
            Folder = "";

            Event = "";
            Operator = "";
            Typeparameter = "";
          };
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
              columns = [
                {
                  __unkeyed-1 = "label";
                  __unkeyed-2 = "label_description";
                  gap = 1;
                }
                ["kind_icon" "kind"]
                ["source_name"]
              ];
              treesitter = ["lsp"];
            };
          };
        };
        snippets.preset = "luasnip";
        sources = {
          default = ["lsp" "path" "snippets" "buffer" "ripgrep" "copilot"];
          providers = {
            snippets.opts.show_autosnippets = false;
            copilot = {
              async = true;
              module = "blink-copilot";
              name = "Copilot";
              score_offset = -5;
            };
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
              opts.additional_rg_options = ["--glob=!*.pdf"];
            };
          };
        };
      };
    };

    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        suggestion.enabled = false;
      };
    };

    codecompanion = {
      enable = true;
      settings = {
        display.chat.show_header_separator = false;
        strategies = {
          chat.adapter = "ollama";
          inline.adapter = "ollama";
          agent.adapter = "ollama";
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "i";
      key = "<C-k>";
      action.__raw = ''function() if require("luasnip").expandable() then require("luasnip").expand() end end'';
      options.desc = "LuaSnip Expand";
    }
    {
      mode = ["i" "s"];
      key = "<C-;>";
      action.__raw = ''function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) end end'';
      options.desc = "LuaSnip Next Choice";
    }
  ];
}
