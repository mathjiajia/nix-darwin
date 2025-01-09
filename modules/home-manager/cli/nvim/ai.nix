{
  programs.nixvim.plugins = {
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
}
