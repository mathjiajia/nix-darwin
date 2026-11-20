-- Managed by home-manager: modules/home-manager/programs/rex in /etc/nix-darwin.

rex.bind("cmd+`", "client.visibility.toggle")

-- Floating terminals: a toggle for lazygit, yazi and btop.
require("floats")
rex.bind("ctrl+cmd+g", "toggle_lazygit")
rex.bind("ctrl+cmd+y", "toggle_yazi")
rex.bind("ctrl+cmd+b", "toggle_btop")

-- agent_send: Neovim pastes text into the agent in another pane.
require("agents")

require("projects")

-- require("ui_bridge") -- stored with Neovim's rex-ui

-- >>> leaf >>>
dofile("/Users/jia/.config/rex/plugins/leaf/init.lua").setup({ bin = { "/Users/jia/.local/bin/leaf" } })
-- <<< leaf <<<
