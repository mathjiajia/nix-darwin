{
  # Send text to the agent in another Rex pane, such as Claude Code.
  # The agent_send action comes from ~/.config/rex/agents.lua.
  extraFiles."lua/rex-agent.lua".source = ./agent.lua;
  extraConfigLua = ''require("rex-agent")'';
}
