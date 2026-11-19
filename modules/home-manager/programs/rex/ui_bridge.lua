-- Server actions let rex do show Neovim's prompts. Call rex.ui directly
-- from run so Rex can suspend the action while the palette is open.
if rex.ui == nil then return end

local function answer(value, reason, detail)
	if value == nil then
		return { reason = reason, detail = detail }
	end
	return { value = value }
end

local input_args = {
	title = "string",
	placeholder = "string?",
	value = "string?",
	confirm = "string?",
	timeout = "number?",
}
local pick_args = { items = "array" }
for name, kind in pairs(input_args) do pick_args[name] = kind end

rex.action {
	name = "ui_pick",
	title = "Prompt Bridge: Pick from a List",
	description = "Shows the choices passed to rex do ui_pick.",
	category = "Prompts",
	args = pick_args,
	run = function (_, args)
		---@cast args rex.ui.PickPrompt
		return answer(rex.ui.pick(args))
	end,
}

rex.action {
	name = "ui_input",
	title = "Prompt Bridge: Ask for Text",
	description = "Shows the prompt passed to rex do ui_input.",
	category = "Prompts",
	args = input_args,
	run = function (_, args)
		---@cast args rex.ui.InputPrompt
		return answer(rex.ui.input(args))
	end,
}
