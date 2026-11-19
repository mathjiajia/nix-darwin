-- Toggle one float per tool in a tab, or one Lazygit float per repository.
local TERMINAL = "com.superlogical.terminal"
local HOME = os.getenv("HOME")
local CD_DIR = HOME .. "/.cache/rex"

-- Q leaves the cwd file empty, so the underlying shell stays where it is.
local YAZI = [[
tmp=$(mktemp -t yazi-cwd.XXXXXX) || exit
trap 'rm -f "$tmp"' EXIT
yazi --cwd-file="$tmp"
IFS= read -r -d '' dir < "$tmp"
if [ -n "$dir" ]; then
	"${REX_BIN_DIR:+$REX_BIN_DIR/}rex" do float_cd -s "$REX_SESSION" -b "$REX_BLOCK" "dir=$dir"
fi
]]

local TOOLS = {
	{ name = "lazygit", title = "Lazygit", per_repo = true },
	{ name = "yazi", title = "Yazi", command = { "bash", "-c", YAZI } },
	{ name = "btop", title = "Btop" },
}

local function repo_root(dir)
	-- Resolve symlinks before looking for the nearest .git directory or file.
	local physical = rex.exec({ "pwd", "-P" }, { cwd = dir })
	if physical and physical.ok then dir = physical.stdout:gsub("\n$", "") end
	while dir do
		local git = io.open(dir .. "/.git")
		if git then
			git:close()
			return dir
		end
		dir = dir:match("^(.*)/[^/]+$")
		if dir == "" then dir = "/" end
	end
end

local function pane_cwd(block_id)
	if not block_id then return nil end
	local process = rex.block.call(TERMINAL, "process", { block_id = block_id }) or {}
	if process.foreground and process.foreground.cwd then return process.foreground.cwd end
	return process.child and process.child.cwd
end

local function contains(layer, block_id)
	for _, block in ipairs(layer.blocks or {}) do
		if block.block_id == block_id then return true end
	end
	return false
end

-- Look up the source and its layer in the same snapshot used to find floats.
local function current_window(block_id)
	local view = assert(rex.session.view {})
	local active
	for _, window in ipairs(view.windows or {}) do
		if window.window_id == view.active_window_id then active = window end
		if block_id then
			for _, layer in ipairs(window.layers or {}) do
				if contains(layer, block_id) then return window, layer end
			end
		end
	end
	assert(active, "there is no tab to float in")
	return active
end

local function toggle_layer(window, layer)
	if layer.state ~= "minimized" and contains(layer, window.focused_block_id) then
		return assert(rex.session.set_layer_state { layer_id = layer.layer_id, state = "minimized" })
	end
	return assert(rex.session.set_layer_state { layer_id = layer.layer_id, state = "normal", focus = true })
end

local function toggle(ctx, tool, cwd)
	local window, origin = current_window(ctx.block_id)
	local name = tool.name
	-- Inside a float, keep toggling that float even if its cwd has changed.
	if origin and origin.kind == "floating" then
		for _, block in ipairs(origin.blocks or {}) do
			local label = block.label or ""
			if label == name or label:sub(1, #name + 1) == name .. " " then
				return toggle_layer(window, origin)
			end
		end
	end

	local label = name
	if tool.per_repo then
		cwd = cwd or pane_cwd(ctx.block_id)
		if cwd then
			cwd = repo_root(cwd) or cwd
			local shown = cwd
			if cwd == HOME or cwd:sub(1, #HOME + 1) == HOME .. "/" then
				shown = "~" .. cwd:sub(#HOME + 1)
			end
			label = name .. " " .. shown
		end
	end
	for _, layer in ipairs(window.layers or {}) do
		if layer.kind == "floating" then
			for _, block in ipairs(layer.blocks or {}) do
				if block.label == label then return toggle_layer(window, layer) end
			end
		end
	end

	if not tool.per_repo then cwd = cwd or pane_cwd(ctx.block_id) end
	return assert(rex.session.new_layer {
		window_id = window.window_id,
		bounds = { 0.05, 0.05, 0.9, 0.9 },
		focus = true,
		layout = rex.layout.block {
			flavor = TERMINAL .. ".shell",
			label = label,
			options = { command = tool.command or { name }, cwd = cwd },
		},
	})
end

for _, tool in ipairs(TOOLS) do
	rex.action {
		name = "toggle_" .. tool.name,
		title = "Toggle " .. tool.title,
		category = "Floats",
		args = { cwd = "string?" },
		run = function (ctx, args) return toggle(ctx, tool, args.cwd) end,
	}
end

rex.action {
	name = "float_cd",
	title = "Change Directory under Float",
	description = "Hides an exiting float and passes the directory to the fish shell below it.",
	category = "Floats",
	args = { dir = "string" },
	run = function (ctx, args)
		local window, origin = current_window(ctx.block_id)
		if not origin or origin.kind ~= "floating" then return { changed = false } end
		if origin.state ~= "minimized" then
			assert(rex.session.set_layer_state { layer_id = origin.layer_id, state = "minimized" })
			window = current_window(ctx.block_id)
		end
		local under = window.focused_block_id
		if not under or under == ctx.block_id then return { changed = false } end
		local process = rex.block.call(TERMINAL, "process", { block_id = under })
		local shell = process and process.foreground
		if not shell or shell.name ~= "fish" or shell.cwd == args.dir then return { changed = false } end

		local mkdir, err = rex.exec({ "mkdir", "-p", CD_DIR })
		if not mkdir or not mkdir.ok then error(err or mkdir.stderr, 0) end

		-- Publish the whole path before the fish signal handler can read it.
		local path = CD_DIR .. "/float-cd." .. shell.pid
		local pending = path .. ".tmp"
		local file = assert(io.open(pending, "w"))
		local written, write_err = file:write(args.dir)
		local closed, close_err = file:close()
		if not written or not closed then
			os.remove(pending)
			error(write_err or close_err, 0)
		end
		local published
		published, err = os.rename(pending, path)
		if not published then
			os.remove(pending)
			error(err, 0)
		end
		local signal
		signal, err = rex.exec({ "kill", "-WINCH", tostring(shell.pid) })
		if not signal or not signal.ok then
			os.remove(path)
			error(err or signal.stderr, 0)
		end
		return { changed = true, block_id = under }
	end,
}
