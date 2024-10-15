require("conform").setup({
	formatters_by_ft = {
		bib = { "bibtex-tidy" },
		c = { "clang-format" },
		css = { "prettierd" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		fish = { "fish_indent" },
		markdown = { "prettierd" },
		["markdown.mdx"] = { "prettierd" },
		yaml = { "prettierd" },
		lua = { "stylua" },
		nix = { "nixfmt" },
		python = { "black" },
		sh = { "shfmt" },
		swift = { "swift_format" },
		tex = { "latexindent" },
		toml = { "taplo" },
	},
	formatters = {
		latexindent = {
			prepend_args = { "-c", "./.aux", "-m" },
		},
		["bibtex-tidy"] = {
			prepend_args = {
				"--curly",
				"--tab",
				"--trailing-commas",
				"--sort-fields=author,year,month,day,title,shorttitle",
				"--remove-braces",
			},
		},
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 2000,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cF", function()
	require("conform").format({ formatters = { "injected" }, timeout_ms = 2000 })
end, { desc = "Format Injected Langs" })
