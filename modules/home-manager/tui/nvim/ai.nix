{pkgs, ...}: {
  programs.nixvim.plugins.codecompanion = {
    enable = true;
    package = pkgs.vimPlugins.codecompanion-nvim.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "olimorris";
        repo = "codecompanion.nvim";
        rev = "19d665a9b13c0b05652c359c4302465b8b2543be";
        sha256 = "zY9uWB11mr/XDAw/l4HLAy3ZHaIhUiYlzUFbiKVFSvg=";
      };
      postInstall =
        oldAttrs.postInstall
          or ""
        + # sh
        ''find $out/doc -mindepth 1 ! -name "codecompanion.txt" -delete'';
    });
    settings = {
      adapters = {
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
