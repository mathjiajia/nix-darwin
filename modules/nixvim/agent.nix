{
  # Send text to the agent in another Rex pane, such as Claude Code. The
  # agent_send action comes from ~/.config/rex/agents.lua.
  extraFiles."lua/rex-agent.lua".source = ./agent.lua;

  keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>as";
      action.__raw = "function() require('rex-agent').send_lines() end";
      options.desc = "[A]gent: [S]end Line or Selection";
    }
    {
      mode = "n";
      key = "<leader>ad";
      action.__raw = "function() require('rex-agent').send_diagnostics() end";
      options.desc = "[A]gent: Send Line [D]iagnostics";
    }
  ];
}
