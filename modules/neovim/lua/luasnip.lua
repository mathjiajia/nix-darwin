			local ls = require("luasnip")
			local types = require("luasnip.util.types")

			ls.setup({
				update_events = "TextChanged,TextChangedI",
				delete_check_events = "TextChanged",
				ext_opts = {
					[types.insertNode] = { active = { virt_text = { { "", "Boolean" } } } },
					[types.choiceNode] = { active = { virt_text = { { "󱥸", "Special" } } } },
				},
				enable_autosnippets = true,
				store_selection_keys = "<Tab>",
			})

			vim.keymap.set("i", "<C-k>", function()
				if ls.expandable() then
					ls.expand()
				end
			end, { desc = "LuaSnip Expand" })

			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if ls.locally_jumpable(1) then
					ls.jump(1)
				end
			end, { desc = "LuaSnip Forward Jump" })

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.locally_jumpable(-1) then
					ls.jump(-1)
				end
			end, { desc = "LuaSnip Backward Jump" })

			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { desc = "LuaSnip Next Choice" })
