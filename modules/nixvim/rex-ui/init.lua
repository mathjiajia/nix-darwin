-- Route Neovim prompts and previewless pickers through Rex's command palette.
local max_items = 2000 -- the most Rex lists
local notice = { title = "Rex UI" }

-- The pickers outside Rex, and what they fall back to when Rex can't ask.
local snacks = {
	buffers = function () return Snacks.picker.buffers({ layout = "select" }) end,
	pickers = function () return Snacks.picker({ layout = "select" }) end,
	command_history = function () return Snacks.picker.command_history() end,
	search_history = function () return Snacks.picker.search_history() end
}

-- Outside Rex, vim.ui.select and vim.ui.input stay as they are.
if vim.env.REX_SERVER == nil or vim.fn.executable("rex") ~= 1 then
	return snacks
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

	local function unanswered()
		return on_answer(nil)
	end
	-- What follows each reason Rex gives for returning no value, called with
	-- Rex's detail. Any other reason, such as no_client, falls back quietly.
	local on_reason = {
		cancelled = unanswered,
		timeout = unanswered,
		busy = function ()
			vim.notify("Rex is already showing a prompt", vim.log.levels.WARN, notice)
			return on_answer(nil)
		end,
		failed = failed
	}

	local function on_exit(result)
		local decoded, response = pcall(vim.json.decode, result.stdout)
		if result.code ~= 0 or not decoded or type(response) ~= "table" then
			return failed(result.stderr ~= "" and result.stderr or result.stdout)
		end
		if type(response.value) == "string" then
			return on_answer(response.value)
		end
		return (on_reason[response.reason] or fallback)(response.detail)
	end

	local ok, err = pcall(vim.system, { "rex", "do", action, "--args", "-", "--json" }, {
		stdin = vim.json.encode(prompt),
		text = true
	}, vim.schedule_wrap(on_exit)
	)
	if not ok then
		return failed(err)
	end
end

-- Snacks is configured in default.nix to set neither vim.ui handler, so these
-- two stay in place, and Neovim's own are what they fall back to.
local select, input = vim.ui.select, vim.ui.input

vim.ui.select = function (items, opts, on_choice)
	opts = opts or {}
	local function fallback()
		return select(items, opts, on_choice)
	end
	if #items > max_items then
		return fallback()
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
	end, fallback
	)
end

vim.ui.input = function (opts, on_confirm)
	opts = opts or {}
	local function fallback()
		return input(opts, on_confirm)
	end
	-- Rex's field has no completion.
	if opts.completion then
		return fallback()
	end
	ask("ui_input", { title = title(opts.prompt, "Input"), value = opts.default }, on_confirm, fallback)
end

local function buffers()
	local window = vim.api.nvim_get_current_win()
	local infos = vim.tbl_filter(function (info)
		return vim.bo[info.bufnr].buftype ~= "nofile"
	end, vim.fn.getbufinfo({ buflisted = 1 }))
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
			detail = flags ~= "" and flags or nil
		}
	end
	ask("ui_pick", { title = "Buffers", placeholder = "Filter buffers", items = items }, function (id)
		local buf = tonumber(id)
		if buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_win_is_valid(window) then
			vim.api.nvim_win_set_buf(window, buf)
		end
	end, snacks.buffers
	)
end

local function pickers()
	local names = vim.tbl_keys(require("snacks.picker.config").get().sources)
	table.sort(names)
	ask("ui_pick", { title = "Snacks Pickers", placeholder = "Filter pickers", items = names }, function (name)
		if name then Snacks.picker(name) end
	end, snacks.pickers
	)
end

local function history(name, kind, key, label)
	return function ()
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
		end, snacks[name]
		)
	end
end

return {
	buffers = buffers,
	pickers = pickers,
	command_history = history("command_history", "cmd", ":", "Command History"),
	search_history = history("search_history", "search", "/", "Search History")
}
