{pkgs, ...}: {
  programs.nixvim.plugins.codecompanion = {
    enable = true;
    package = pkgs.vimPlugins.codecompanion-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        oldAttrs.postInstall
          or ""
        + # sh
        ''find $out/doc -mindepth 1 ! -name "codecompanion.txt" -delete'';
    });
    settings = {
      adapters.http = {
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
          				default = "qwen-max",
          				choices = {
          					"qwen-max",
          					"qwen3-235b-a22b",
          					"qwen3-coder-480b-a35b-instruct",
          				},
          			},
          		},
          	})
          end
        '';
      };
      strategies.chat.opt.completion_provider = "blink";
      display = {
        action_palette.provider = "snacks";
        diff.provider = "mini_diff";
        chat.window.opts = {
          conceallevel = 2;
          colorcolumn = "";
          number = false;
          relativenumber = false;
        };
      };
    };
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
