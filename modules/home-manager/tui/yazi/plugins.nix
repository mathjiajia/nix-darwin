{
  inputs,
  pkgs,
  ...
}: let
  arrowPlugin = pkgs.writeTextFile {
    name = "arrow.yazi";
    destination = "/main.lua";
    text =
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
  };
  parentArrowPlugin = pkgs.writeTextFile {
    name = "parent-arrow.yazi";
    destination = "/main.lua";
    text =
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
in {
  programs.yazi.plugins = {
    arrow = arrowPlugin;
    chmod = "${inputs.yazi-plugins}/chmod.yazi";
    diff = "${inputs.yazi-plugins}/diff.yazi";
    full-border = "${inputs.yazi-plugins}/full-border.yazi";
    git = "${inputs.yazi-plugins}/git.yazi";
    jump-to-char = "${inputs.yazi-plugins}/jump-to-char.yazi";
    parent-arrow = parentArrowPlugin;
    smart-enter = "${inputs.yazi-plugins}/smart-enter.yazi";
    smart-filter = "${inputs.yazi-plugins}/smart-filter.yazi";
  };
}
