{
  programs.nixvim.plugins = {
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

    copilot-lua.enable = false;
    blink-copilot.enable = true;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
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
            "copilot"
          ];
          providers = {
            snippets.opts.show_autosnippets = false;
            copilot = {
              async = true;
              module = "blink-copilot";
              name = "Copilot";
            };
            ripgrep = {
              module = "blink-ripgrep";
              name = "Ripgrep";
            };
          };
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = [
        "i"
        "s"
      ];
      key = "<C-;>";
      action.__raw = ''function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) end end'';
      options.silent = true;
      options.desc = "LuaSnip";
    }
  ];
}
