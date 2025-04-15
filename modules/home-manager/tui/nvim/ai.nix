{
  programs.nixvim.plugins.codecompanion = {
    enable = true;
    settings = {
      adapters = {
        copilot.__raw = ''
          function()
          	return require("codecompanion.adapters").extend("copilot", {
          		schema = { model = { default = "o4-mini" } },
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
      };
      display = {
        action_palette.provider = "default";
        diff.provider = "mini_diff";
        chat.window.opts = {
          conceallevel = 2;
          colorcolumn = "";
        };
      };
    };
  };

  programs.nixvim.extraFiles = {
    "lua/util/template/user/builder.lua".text =
      # lua
      ''
        return { "user.builder.clang", "user.builder.swift" }
      '';
  };

  programs.nixvim.keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>aa";
      action = "<Cmd>CodeCompanionActions<CR>";
      options.desc = "CodeCompanion Actions";
    }
    {
      mode = ["n" "v"];
      key = "<leader>ac";
      action = "<Cmd>CodeCompanionChat<CR>";
      options.desc = "CodeCompanion Chat";
    }
    {
      mode = ["n" "v"];
      key = "<leader>ae";
      action.__raw = ''
        function()
        	local prompt = vim.fn.input("Inline Assistant: ")
        	if prompt ~= "" then
        		vim.cmd.CodeCompanion(prompt)
        	end
        end
      '';
      options.desc = "CodeCompanion Inline Assistant";
    }
  ];
}
