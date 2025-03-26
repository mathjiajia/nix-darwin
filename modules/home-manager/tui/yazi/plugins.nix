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

    arrow =
      writePlugin
      # lua
      ''
        --- @sync entry
        return {
          entry = function(_, job)
            local current = cx.active.current
            local new = (current.cursor + job.args[1]) % #current.files
            ya.manager_emit("arrow", { new - current.cursor })
          end,
        }
      '';
    parent-arrow =
      writePlugin
      # lua
      ''
        --- @sync entry
        local function entry(_, job)
        	local parent = cx.active.parent
        	if not parent then return end

        	local target = parent.files[parent.cursor + 1 + job.args[1]]
        	if target and target.cha.is_dir then
        		ya.manager_emit("cd", { target.url })
        	end
        end

        return { entry = entry }
      '';
  };
}
