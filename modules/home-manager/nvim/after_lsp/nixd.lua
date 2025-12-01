return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			options = {
				["nix-darwin"] = {
					expr = "(builtins.getFlake '/private/etc/nix-darwin').darwinConfigurations.Jias-MacBook-Pro.options",
				},
				["home-manager"] = {
					expr = "(builtins.getFlake '/private/etc/nix-darwin').darwinConfigurations.Jias-MacBook-Pro.options.home-manager.users.type.getSubOptions []",
				},
			},
		},
	},
}
