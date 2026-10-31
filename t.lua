if vim.env.REX_BLOCK then
	local osc52 = require("vim.ui.clipboard.osc52")
	local function paste()
		return 0
	end

	vim.g.clipboard = {
		name = "OSC 52 (copy only)",
		copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
		paste = { ["+"] = paste, ["*"] = paste }
	}
end
