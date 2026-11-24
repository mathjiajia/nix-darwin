local TERMINAL = "com.superlogical.terminal"
local HOME = os.getenv("HOME")

local function find(items, key, value)
	for _, item in ipairs(items or {}) do
		if item[key] == value then return item end
	end
end

-- A CLI action can target a pane in a background tab.
local function location(block_id)
	local view = assert(rex.session.view {})
	for _, window in ipairs(view.windows or {}) do
		for _, layer in ipairs(window.layers or {}) do
			if find(layer.blocks, "block_id", block_id) then return window, layer end
		end
	end
	local active = find(view.windows, "window_id", view.active_window_id)
	assert(active, "there is no tab to float in")
	return active
end

local function pane_cwd(block_id)
	local pane = rex.block.call(TERMINAL, "process", { block_id = block_id }) or {}
	return (pane.foreground or {}).cwd or (pane.child or {}).cwd
end

local function lazygit_location(cwd)
	if not cwd then return nil, "lazygit" end
	local root = rex.exec({ "git", "-C", cwd, "rev-parse", "--show-toplevel" })
	if root and root.ok then
		cwd = root.stdout:sub(1, -2)
	else
		-- Inside .git, Git can still identify the repository through a symlink.
		local admin = rex.exec({ "git", "-C", cwd, "rev-parse", "--absolute-git-dir" })
		if admin and admin.ok then
			local git_dir = admin.stdout:sub(1, -2)
			local parent = (git_dir .. "/"):match("^(.*)/%.git/")
			if parent then cwd = parent ~= "" and parent or "/" end
		end
	end
	local path = cwd
	if cwd == HOME or cwd:sub(1, #HOME + 1) == HOME .. "/" then
		path = "~" .. cwd:sub(#HOME + 1)
	end
	return cwd, "lazygit " .. path
end

local function toggle_layer(window, layer)
	local focused = find(layer.blocks, "block_id", window.focused_block_id)
	local result = assert(rex.session.set_layer_state {
			layer_id = layer.layer_id,
			state = focused and "minimized" or "normal",
			focus = not focused
		})
	return result
end

local function register_float(title, command)
	local name = title:lower()
	rex.action {
		name = "toggle_" .. name,
		title = "Toggle " .. title,
		category = "Floats",
		args = { cwd = "string?" },
		run = function (ctx, args)
			local window, origin = location(ctx.block_id)
			-- The shortcut inside a tool belongs to that float, even if its cwd changed.
			if origin and origin.kind == "floating" then
				for _, block in ipairs(origin.blocks) do
					if (block.label or ""):match("^[^ ]+") == name then return toggle_layer(window, origin) end
				end
			end
			local source = ctx.block_id or window.focused_block_id
			local cwd, label = args.cwd, name
			if name == "lazygit" then
				cwd, label = lazygit_location(cwd or pane_cwd(source))
			end
			for _, layer in ipairs(window.layers or {}) do
				if layer.kind == "floating" and find(layer.blocks, "label", label) then
					return toggle_layer(window, layer)
				end
			end
			local result = assert(rex.session.new_layer {
					window_id = window.window_id,
					bounds = { 0.05, 0.05, 0.9, 0.9 },
					focus = true,
					layout = rex.layout.block {
						flavor = TERMINAL .. ".shell",
						label = label,
						options = { command = command or { name }, cwd = cwd or pane_cwd(source) }
					}
				})
			return result
		end
	}
end

register_float("Lazygit")
register_float("Yazi", {
	"bash",
	"-c",
	[[
		tmp=$(mktemp -t yazi-cwd.XXXXXX) || exit
		trap 'rm -f "$tmp"' EXIT

		yazi --cwd-file="$tmp"
		IFS= read -r -d '' dir < "$tmp"
		if [ -n "$dir" ]; then
			"${REX_BIN_DIR:+$REX_BIN_DIR/}rex" do float_cd -b "$REX_BLOCK" "dir=$dir"
		fi
	]]
})
register_float("Btop")

rex.action {
	name = "float_cd",
	title = "Change Directory under Float",
	category = "Floats",
	description = "Hides an exiting float and passes the directory to the Fish shell below it.",
	args = { dir = "string" },
	run = function (ctx, args)
		local window, layer = location(ctx.block_id)
		if not layer or layer.kind ~= "floating" then return { changed = false } end
		if layer.state ~= "minimized" then
			assert(rex.session.set_layer_state { layer_id = layer.layer_id, state = "minimized" })
			window = location(ctx.block_id)
		end
		local under = window.focused_block_id
		if not under or under == ctx.block_id then return { changed = false } end
		local pane = rex.block.call(TERMINAL, "process", { block_id = under })
		local shell = pane and pane.foreground
		if not shell or shell.name ~= "fish" or shell.cwd == args.dir then return { changed = false } end

		-- Publish the whole path before waking the Fish handler in default.nix.
		local sent = assert(rex.exec({
				"sh",
				"-ec",
				[[
					file=$1/float-cd.$2
					mkdir -p "$1"
					tmp=$(mktemp "$file.XXXXXX")
					trap 'rm -f "$tmp"' EXIT

					printf %s "$3" > "$tmp"
					mv -f "$tmp" "$file"
					kill -WINCH "$2" || {
						rm -f "$file"
						exit 1
					}
				]],
				"float_cd",
				HOME .. "/.cache/rex",
				tostring(shell.pid),
				args.dir
			}))
		assert(sent.ok, sent.stderr)
		return { changed = true, block_id = under }
	end
}

-- Neovim runs as a screen process, which Rex reports as the foreground, and a
-- server child that owns the socket at Neovim's default address.
local NVIM_REMOTE = [[
	server=$(pgrep -P "$1" -x nvim | head -n 1)
	for socket in "${TMPDIR:-/tmp}"/nvim."$(id -un)"/*/nvim."${server:-$1}".0; do
		if [ -S "$socket" ]; then exec "$2" --server "$socket" --remote-expr "$3"; fi
	done
	echo "Neovim $1 has no server socket" >&2
	exit 1
]]

local function vim_string(s)
	return "'" .. s:gsub("'", "''") .. "'"
end

rex.action {
	name = "float_edit",
	title = "Edit in Neovim under Float",
	category = "Floats",
	description = "Opens files in a Neovim in the same tab, hides the float it runs in, and focuses Neovim. Fails, changing nothing, when there is no Neovim to open them in.",
	args = { files = "array", line = "integer?" },
	run = function (ctx, args)
		if #args.files == 0 then error("there are no files to open", 0) end
		local window, layer = location(ctx.block_id)
		local neovims = {}
		for _, tiled in ipairs(window.layers or {}) do
			for _, block in ipairs(tiled.kind ~= "floating" and tiled.blocks or {}) do
				if block.creator_name == TERMINAL and block.block_id ~= ctx.block_id then
					local pane = rex.block.call(TERMINAL, "process", { block_id = block.block_id })
					local nvim = pane and pane.foreground
					if nvim and nvim.name == "nvim" then neovims[#neovims + 1] = { block_id = block.block_id, process = nvim } end
				end
			end
		end
		if #neovims == 0 then error("there is no Neovim in this tab", 0) end

		-- Of several, take the Neovim that hiding the float gives the focus back to.
		local floating = layer and layer.kind == "floating"
		if floating and layer.state ~= "minimized" then
			assert(rex.session.set_layer_state { layer_id = layer.layer_id, state = "minimized" })
		end
		local under = floating and location(ctx.block_id).focused_block_id
		local target = neovims[1]
		for _, nvim in ipairs(neovims) do
			if nvim.block_id == under then target = nvim end
		end

		-- :drop goes to a window that already shows the file.
		local files = {}
		for i, file in ipairs(args.files) do files[i] = vim_string(file) end
		local command = "drop" .. (args.line and (" +%d"):format(args.line) or "")
		local expr = ("execute(%s .. ' ' .. join(map([%s], 'fnameescape(v:val)')))")
			:format(vim_string(command), table.concat(files, ", "))
		local nvim = target.process
		local opened = rex.exec({ "sh", "-c", NVIM_REMOTE, "float_edit", tostring(nvim.pid), nvim.path or "nvim", expr }, { timeout = 3 })
		if not (opened and opened.ok) then
			if floating then rex.session.set_layer_state { layer_id = layer.layer_id, state = "normal", focus = true } end
			error("Neovim did not open the files: " .. (opened and opened.stderr:gsub("%s+$", "") or "it did not start"), 0)
		end
		assert(rex.session.focus_block { block_id = target.block_id })
		return { opened = true, block_id = target.block_id }
	end
}
