{
  programs.nixvim.extraConfigLua =
    # lua
    ''
      vim.lsp.config("sourcekit", {
      	cmd = { "sourcekit-lsp" },
      	filetypes = { "swift", "objc", "objcpp" },
      	root_markers = {
      		"buildServer.json",
      		"*.xcodeproj",
      		"*.xcworkspace",
      		"compile_commands.json",
      		"Package.swift",
      		".git",
      	},
      	get_language_id = function(_, ftype)
      		local t = { objc = "objective-c", objcpp = "objective-cpp" }
      		return t[ftype] or ftype
      	end,
      })
    '';
}
