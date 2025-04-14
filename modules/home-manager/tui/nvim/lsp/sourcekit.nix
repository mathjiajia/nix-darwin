{
  programs.nixvim.extraFiles."lsp/sourcekit.lua".text =
    # lua
    ''
      return {
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
      	capabilities = {
      		workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
      		textDocument = {
      			diagnostic = {
      				dynamicRegistration = true,
      				relatedDocumentSupport = true,
      			},
      		},
      	},
      }
    '';
}
