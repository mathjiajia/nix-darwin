{
  programs.nixvim.plugins = {
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
