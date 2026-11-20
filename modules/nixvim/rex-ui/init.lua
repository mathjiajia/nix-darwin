-- Route Neovim prompts and previewless pickers through Rex's command palette.
local max_items = 2000
local notice = { title = "Rex UI" }

-- The CLI of the Rex that started this terminal, as floats.lua runs it.
local REX = (vim.env.REX_BIN_DIR or "") ~= "" and vim.env.REX_BIN_DIR .. "/rex" or "rex"

local function available()
	return vim.env.REX_SERVER ~= nil and vim.fn.executable(REX) == 1
end

local function title(prompt, default)
	local label = vim.trim((prompt or ""):gsub("[%s:]*$", ""))
	return label ~= "" and label or default
end

local function ask(action, prompt, on_answer, fallback)
	local function failed(message)
		vim.notify_once(("Rex %s failed: %s"):format(action, vim.trim(tostring(message))), vim.log.levels.WARN, notice)
		return fallback()
	end

	local ok, err = pcall(vim.system, { REX, "do", action, "--args", "-", "--json" }, {
		stdin = vim.json.encode(prompt),
		text = true,
	}, vim.schedule_wrap(function (result)
		if result.code ~= 0 then
			return failed(result.stderr ~= "" and result.stderr or result.stdout)
		end
		local decoded, response = pcall(vim.json.decode, result.stdout)
		if not decoded or type(response) ~= "table" then
			return failed(result.stdout)
		end
		if type(response.value) == "string" then
			return on_answer(response.value)
		end
		local reason = response.reason
		if reason == "cancelled" or reason == "timeout" then
			return on_answer(nil)
		end
		if reason == "busy" then
			vim.notify("Rex is already showing a prompt", vim.log.levels.WARN, notice)
			return on_answer(nil)
		end
		if reason == "failed" then
			return failed(tostring(response.detail))
		end
		return fallback()
	end))
	if not ok then
		return failed(err)
	end
end

local function install()
	local select, input = vim.ui.select, vim.ui.input

	vim.ui.select = function (items, opts, on_choice)
		opts = opts or {}
		if #items == 0 or #items > max_items or opts.preview_item or not available() then
			return select(items, opts, on_choice)
		end
		local format = opts.format_item or tostring
		local list = {}
		for i, item in ipairs(items) do
			local text = format(item)
			if type(text) == "string" then
				text = text:match("^[^\n]*")
			else
				text = tostring(item)
			end
			list[i] = { id = tostring(i), title = text ~= "" and text or nil }
		end
		ask("ui_pick", { title = title(opts.prompt, "Select"), items = list }, function (id)
			local index = tonumber(id)
			on_choice(index and items[index], index)
		end, function ()
			select(items, opts, on_choice)
		end)
	end

	vim.ui.input = function (opts, on_confirm)
		opts = opts or {}
		if opts.completion or opts.highlight or not available() then
			return input(opts, on_confirm)
		end
		ask("ui_input", { title = title(opts.prompt, "Input"), value = opts.default }, on_confirm, function ()
			input(opts, on_confirm)
		end)
	end
end

-- Snacks installs vim.ui handlers at UIEnter. Wrap them after it runs.
if vim.v.vim_did_enter == 1 then
	install()
else
	vim.api.nvim_create_autocmd("UIEnter", { once = true, callback = function () vim.schedule(install) end })
end

local function buffers()
	local window = vim.api.nvim_get_current_win()
	local function fallback()
		if not vim.api.nvim_win_is_valid(window) then return end
		vim.api.nvim_set_current_win(window)
		return Snacks.picker.buffers({ layout = "select" })
	end
	if not available() then return fallback() end
	local infos = vim.tbl_filter(function (info)
		return vim.bo[info.bufnr].buftype ~= "nofile"
	end, vim.fn.getbufinfo({ buflisted = 1 }))
	if #infos > max_items then return fallback() end
	table.sort(infos, function (a, b) return a.lastused > b.lastused end)

	local current, alternate = vim.api.nvim_get_current_buf(), vim.fn.bufnr("#")
	local items = {}
	for i, info in ipairs(infos) do
		local buf = info.bufnr
		local flags = ""
		if buf == current then
			flags = "%"
		elseif buf == alternate then
			flags = "#"
		end
		if vim.bo[buf].readonly then flags = flags .. "=" end
		if info.changed == 1 then flags = flags .. "+" end
		items[i] = {
			id = tostring(buf),
			title = info.name ~= "" and vim.fn.fnamemodify(info.name, ":~:.") or "[Scratch]",
			icon = vim.bo[buf].buftype == "terminal" and "terminal" or "document",
			detail = flags ~= "" and flags or nil,
		}
	end
	ask("ui_pick", { title = "Buffers", placeholder = "Filter buffers", items = items }, function (id)
		local buf = tonumber(id)
		if buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_is_valid(window) then
			vim.api.nvim_win_set_buf(window, buf)
		end
	end, fallback)
end

local function pickers()
	local function fallback()
		return Snacks.picker({ layout = "select" })
	end
	if not available() then return fallback() end
	local ok, config = pcall(require, "snacks.picker.config")
	if not ok then return fallback() end
	local names = vim.tbl_keys(config.get().sources)
	if #names > max_items then return fallback() end
	table.sort(names)
	ask("ui_pick", { title = "Snacks Pickers", placeholder = "Filter pickers", items = names }, function (name)
		if name then Snacks.picker(name) end
	end, fallback)
end

local function history(name, kind, key, label)
	local function fallback()
		return Snacks.picker[name]()
	end
	return function ()
		if not available() then return fallback() end
		local items = {}
		-- Relative indices stop at the oldest retained entry even after the
		-- history numbers have grown beyond the ring size.
		for i = 1, vim.o.history do
			local line = vim.fn.histget(kind, -i)
			if line == "" then break end
			if line:find("%S") then
				items[#items + 1] = { id = tostring(#items + 1), title = line }
				if #items == max_items then break end
			end
		end
		ask("ui_pick", { title = label, placeholder = "Filter history", items = items }, function (id)
			local item = items[tonumber(id)]
			if item then
				vim.api.nvim_input(key)
				vim.schedule(function () vim.fn.setcmdline(item.title) end)
			end
		end, fallback)
	end
end

return {
	buffers = buffers,
	pickers = pickers,
	command_history = history("command_history", "cmd", ":", "Command History"),
	search_history = history("search_history", "search", "/", "Search History"),
}
