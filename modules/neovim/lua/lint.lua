local lint = require("lint")

lint.linters_by_ft = {
	bash = { "shellcheck" },
	fish = { "fish" },
	gitcommit = { "commitlint" },
	markdown = { "markdownlint-cli2" },
	zsh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
