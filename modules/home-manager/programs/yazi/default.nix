{ pkgs, ... }: {
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.yazi = {
    enable = true;
    # Give Rex its own identity and the same Kitty renderer as Ghostty.
    package = pkgs.yazi.override {
      yazi-unwrapped = pkgs.yazi-unwrapped.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [ ./rex-kitty-graphics.patch ];
      });
    };
    shellWrapperName = "y";
    initLua =
      # lua
      ''
        function Linemode:size_and_mtime()
        	local time = math.floor(self._file.cha.mtime or 0)
        	if time == 0 then
        		time = ""
        	elseif os.date("%Y", time) == os.date("%Y") then
        		time = os.date("%b %d %H:%M", time)
        	else
        		time = os.date("%b %d  %Y", time)
        	end

        	local size = self._file:size()
        	return string.format("%s %s", size and ya.readable_size(size) or "-", time)
        end

        require("full-border"):setup({ set = "rounded" })
        require("git"):setup({ order = 1500 })
      '';
  };
}
