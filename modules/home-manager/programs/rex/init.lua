rex.bind("cmd+`", "client.visibility.toggle")

rex.action {
	name = "float",
	title = "Open Floating Terminal",
	args = { command = "array", cwd = "string", label = "string?" },
	run = function (ctx, args)
		local origin, err = rex.session.describe_block { block_id = ctx.block_id }
		if not origin then error(err, 0) end
		local float, layer_err = rex.session.new_layer {
			window_id = origin.block.window_id,
			bounds = { 0.05, 0.05, 0.9, 0.9 },
			focus = true,
			layout = rex.layout.block {
				flavor = "com.superlogical.terminal.shell",
				label = args.label or args.command[1],
				options = { command = args.command, cwd = args.cwd }
			}
		}
		if layer_err then error(layer_err, 0) end
		return float
	end
}
