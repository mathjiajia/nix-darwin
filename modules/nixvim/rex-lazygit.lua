-- Launch Lazygit directly in Rex, independently of Neovim terminal plugins.
local M = {}
local floats = {}
local config_file
local rex_path = vim.env.REX_BIN_DIR and (vim.env.REX_BIN_DIR .. "/rex") or "rex"
if vim.fn.executable(rex_path) ~= 1 then
	rex_path = "rex"
end

local function rex(cmd, args)
	local command = { rex_path, "--timeout", "3s" }
	vim.list_extend(command, cmd)
	vim.list_extend(command, {
		vim.json.encode(args),
		"-s",
		vim.env.REX_SESSION
	})
	local result = vim.system(command, { text = true }):wait(4000)
	if result.code ~= 0 then
		error("Rex Lazygit: " .. vim.trim(result.stderr or "request failed"), 0)
	end
	return vim.json.decode(result.stdout)
end

local function editor_config()
	local script = assert(vim.api.nvim_get_runtime_file("rex/lazygit-edit.lua", false)[1])
	local edit = vim.fn.shellescape(vim.v.progpath) .. " --clean -i NONE -l " .. vim.fn.shellescape(script)
	local path = vim.fn.stdpath("cache") .. "/rex-lazygit.yml"
	vim.fn.mkdir(vim.fn.stdpath("cache"), "p")
	-- Lazygit shell-quotes its filename/dir placeholders; don't quote them again.
	vim.fn.writefile({
		"os:",
		"  edit: " .. vim.json.encode(edit .. " {{filename}}"),
		"  editAtLine: " .. vim.json.encode(edit .. " {{filename}} {{line}}"),
		"  openDirInEditor: " .. vim.json.encode(edit .. " {{dir}}"),
		"  editInTerminal: false",
		"  suspendOnEdit: false"
	}, path)
	return path
end

local function open()
	local cwd = vim.fn.getcwd()
	local previous = floats[cwd]
	if previous then
		local ok = pcall(rex, { "api", "call", "session.set_layer_state" }, {
			layer_id = previous.layer_id,
			state = "normal",
			focus = true
		})
		if ok then
			return previous
		end
		floats[cwd] = nil
	end

	local lazygit = vim.fn.exepath("lazygit")
	assert(lazygit ~= "", "lazygit is not available on PATH")
	local configs = vim.env.LG_CONFIG_FILE or ""
	-- Supplying LG_CONFIG_FILE replaces Lazygit's default config discovery.
	-- Keep the user's config first, then layer our Neovim editing commands on top.
	if configs == "" then
		local result = vim.system({ lazygit, "--print-config-dir" }, { text = true, cwd = cwd }):wait(3000)
		assert(result.code == 0, "Could not find Lazygit's config directory: " .. (result.stderr or ""))
		local user_config = vim.fs.joinpath(vim.trim(result.stdout), "config.yml")
		if vim.uv.fs_stat(user_config) then
			configs = user_config
		end
	end
	config_file = config_file or editor_config()
	configs = configs == "" and config_file or (configs .. "," .. config_file)
	local float = rex({ "do", "float", "-b", vim.env.REX_BLOCK, "--args" }, {
		command = {
			"env",
			"NVIM=" .. (vim.v.servername ~= "" and vim.v.servername or vim.fn.serverstart()),
			"LG_CONFIG_FILE=" .. configs,
			lazygit
		},
		cwd = cwd,
		label = "Lazygit"
	})
	floats[cwd] = float
	vim.system(
		{ rex_path, "wait", "-s", vim.env.REX_SESSION, float.block_ids[1] }, {},
		vim.schedule_wrap(function ()
			if floats[cwd] == float then
				floats[cwd] = nil
			end
			vim.cmd.checktime()
		end)
	)
	return float
end

function M.open()
	if vim.g.neovide or not vim.env.REX_SESSION or not vim.env.REX_BLOCK or vim.fn.executable(rex_path) ~= 1 then
		vim.notify("Open Neovim inside a Rex terminal to use Rex Lazygit", vim.log.levels.WARN)
		return
	end
	local ok, result = pcall(open)
	if not ok then
		vim.notify(tostring(result), vim.log.levels.ERROR, { title = "Rex Lazygit" })
		return
	end
	return result
end

-- Called over Neovim RPC by Lazygit's edit command, with data rather than Ex text.
function M.edit(file, line, block)
	vim.cmd.checktime()
	vim.api.nvim_cmd({ cmd = "tabedit", args = { file }, magic = { file = false } }, {})
	if type(line) == "number" then
		vim.api.nvim_win_set_cursor(0, { math.max(1, math.min(line, vim.api.nvim_buf_line_count(0))), 0 })
	end
	for _, float in pairs(floats) do
		if float.block_ids[1] == block then
			rex({ "api", "call", "session.set_layer_state" }, { layer_id = float.layer_id, state = "minimized" })
			break
		end
	end
	rex({ "api", "call", "session.focus_block" }, { block_id = vim.env.REX_BLOCK })
end

return M
