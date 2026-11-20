-- Managed by home-manager: modules/home-manager/programs/rex in /etc/nix-darwin.

rex.bind("cmd+`", "client.visibility.toggle")

-- Floating terminals: a toggle for lazygit, yazi and btop.
require("floats")
rex.bind("alt+cmd+g", "toggle_lazygit")
rex.bind("alt+cmd+y", "toggle_yazi")
rex.bind("alt+cmd+b", "toggle_btop")

-- agent_send: paste text into the agent in another pane.
require("agents")
rex.bind("alt+cmd+a", "agent_send")

require("projects")

-- ui_pick and ui_input: let Neovim ask questions in the palette.
require("ui_bridge")

-- >>> leaf >>>
dofile("/Users/jia/.config/rex/plugins/leaf/init.lua").setup({ bin = { "/Users/jia/.local/bin/leaf" } })
-- <<< leaf <<<
