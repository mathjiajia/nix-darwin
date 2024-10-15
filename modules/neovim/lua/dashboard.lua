require("dashboard").setup({
	disable_move = true,
	shuffle_letter = true,
	config = {
		week_header = { enable = true },
		-- stylua: ignore
		shortcut = {
			{ desc = "󰚰 Update", group = "Identifier", action = "Lazy update", key = "u" },
			{ desc = " Files", group = "Directory", action = "FzfLua files", key = "f" },
			{ desc = "󰤖 Servers", group = "Float", action = "Mason", key = "s" },
			{ desc = " Quit", group = "String", action = function() vim.api.nvim_input("<Cmd>qa<CR>") end, key = "q" },
		},
		project = { action = "FzfLua files cwd=" },
		mru = { cwd_only = true },
	},
})
