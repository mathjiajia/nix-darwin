{
  programs.crush = {
    enable = true;
    settings = {
      providers = {
        ollama = {
          id = "ollama";
          name = "LlamaBarn";
          base_url = "http://localhost:2276/v1/";
          type = "openai";
          models = [
            {
              name = "GPT-oss";
              id = "GPT-OSS 20B";
              context_window = 1000000;
              default_max_tokens = 2000;
            }
            {
              name = "Qwen3";
              id = "Qwen3 2507 Thinking 4B";
              context_window = 1000000;
              default_max_tokens = 2000;
            }
          ];
        };
      };
    };
  };
}
