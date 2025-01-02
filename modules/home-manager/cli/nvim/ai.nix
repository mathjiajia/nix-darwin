{
  programs.nixvim.plugins = {
    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          ollama.__raw =
            # lua
            ''
              function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = { url = "http://127.0.0.1:11434" },
                    schema = {
                        model = { default = "qwq:32b-preview-fp16" },
                        num_ctx = { default = 32768 },
                    },
                })
              end
            '';
        };
        display.chat.show_header_separator = false;
        # strategies = {
        #   chat.adapter = "ollama";
        #   inline.adapter = "ollama";
        #   agent.adapter = "ollama";
        # };
      };
    };
  };
}
