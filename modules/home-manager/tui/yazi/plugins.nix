{pkgs, ...}: let
  writePlugin = text:
    pkgs.writeTextFile rec {
      inherit text;
      name = "main.lua";
      destination = "/${name}";
    };
in {
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    diff = pkgs.yaziPlugins.diff;
    full-border = pkgs.yaziPlugins.full-border;
    git = pkgs.yaziPlugins.git;
    jump-to-char = pkgs.yaziPlugins.jump-to-char;
    smart-enter = pkgs.yaziPlugins.smart-enter;
    smart-filter = pkgs.yaziPlugins.smart-filter;
    vcs-files = pkgs.yaziPlugins.vcs-files;

    parent-arrow =
      writePlugin
      # lua
      ''
        --- @sync entry
        local function entry(_, job)
        	local parent = cx.active.parent
        	if not parent then return end

        	local offset = tonumber(job.args[1])
        	if not offset then return ya.err(job.args[1], 'is not a number') end

        	local start = parent.cursor + 1 + offset
        	local end_ = offset < 0 and 1 or #parent.files
        	local step = offset < 0 and -1 or 1
        	for i = start, end_, step do
        		local target = parent.files[i]
        		if target and target.cha.is_dir then
        			return ya.emit("cd", { target.url })
        		end
        	end
        end

        return { entry = entry }
      '';
  };
}
