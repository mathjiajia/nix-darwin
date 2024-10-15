local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		expandable_indicator = true,
		fields = { "abbr", "menu", "kind" },
		format = function(entry, item)
			local maxwidth = 30
			local icon = require("mini.icons").get("lsp", item.kind)

			if vim.fn.strchars(item.abbr) > maxwidth then
				item.abbr = vim.fn.strcharpart(item.abbr, 0, maxwidth) .. "…"
			end
			item.menu = ({
				buffer = "[Buffer]",
				cmdline = "[Cmd]",
				nvim_lsp = "[LSP]",
				luasnip = "[Snip]",
				neorg = "[Norg]",
				path = "[Path]",
				rg = "[RG]",
			})[entry.source.name]
			item.kind = icon .. " " .. item.kind
			return item
		end,
	},
	window = {
		completion = { border = "rounded", col_offset = -1 },
		documentation = { border = "rounded" },
	},
	---@diagnostic disable-next-line: missing-fields
	matching = { disallow_prefix_unmatching = true },
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip", option = { show_autosnippets = true } },
		{ name = "path" },
	}, {
		{ name = "copilot", max_item_count = 2 },
		{ name = "buffer" },
		{ name = "neorg" },
	}, {
		{ name = "rg", keyword_length = 2 },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { name = "buffer" },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
