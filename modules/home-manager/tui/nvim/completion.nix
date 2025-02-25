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
        fuzzy.implementation = "lua";
        keymap = {
          preset = "default";
          "<C-y>" = {
            __unkeyed-1 = "select_and_accept";
            __unkeyed-2.__raw = ''
              vim.schedule_wrap(function()
              	local ls = require('luasnip')
              	if ls.expandable() then
              		ls.expand()
              	end
              end),
            '';
          };
          "<C-l>" = {
            __unkeyed-1.__raw = ''
              vim.schedule_wrap(function()
              	local ls = require('luasnip')
              	if ls.choice_active() then
              		ls.change_choice(1)
              	end
              end),
            '';
          };
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

    avante = {
      # enable = true;
      settings = {
        # provider = "copilot";
        provider = "aliyun";
        vendors.aliyun = {
          __inherited_from = "openai";
          api_key_name = "ALIYUN_API_KEY";
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1";
          model = "qwen-max-0125";
        };
      };
    };

    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          deepseek.__raw = ''
            function()
            	return require("codecompanion.adapters").extend("deepseek", {
            		url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
            		env = { api_key = "ALIYUN_API_KEY" },
            		schema = {
            			model = {
            				default = "deepseek-r1",
            				choices = { ["deepseek-r1"] = { opts = { can_reason = true } } },
            			},
            		},
            	})
            end
          '';
          aliyun_qwen.__raw = ''
            function()
            	return require("codecompanion.adapters").extend("openai_compatible", {
            		name = "aliyun_qwen",
            		env = {
            			url = "https://dashscope.aliyuncs.com/compatible-mode",
            			api_key = "ALIYUN_API_KEY",
            		},
            		schema = {
            			model = {
            				default = "qwen-max-0125",
            				choices = {
            					"qwen-max-0125",
            					["qwq-plus-2025-03-05"] = { opts = { can_reason = true } },
            				},
            			},
            		},
            	})
            end
          '';
        };
        strategies = {
          chat.adapter = "aliyun_qwen";
          inline.adapter = "ollama";
          agent.adapter = "ollama";
        };
      };
    };
  };
}
