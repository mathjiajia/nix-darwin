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

    copilot-lua.enable = false;
    blink-copilot.enable = true;
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      package = pkgs.vimPlugins.blink-cmp.overrideAttrs (oldAttrs: {
        postInstall =
          oldAttrs.postInstall
          or ""
          + # sh
          ''find $out/doc -mindepth 1 ! -name "blink-cmp.txt" -delete'';
      });
      settings = {
        keymap = {
          preset = "default";
          "<C-y>" = {
            __unkeyed-1 = "select_and_accept";
            __unkeyed-2.__raw = ''
              vim.schedule_wrap(function()
              	local ls = require("luasnip")
              	if ls.expandable() then
              		ls.expand()
              	end
              end),
            '';
          };
          "<C-;>" = {
            __unkeyed-1.__raw = ''
              vim.schedule_wrap(function()
              	local ls = require("luasnip")
              	if ls.choice_active() then
              		ls.change_choice(1)
              	end
              end),
            '';
          };
        };
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
          };
          menu.draw.treesitter = ["lsp"];
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
}
