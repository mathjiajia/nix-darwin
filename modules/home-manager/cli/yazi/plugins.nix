{pkgs, ...}: let
  yaziPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "master";
    sha256 = "1FZ8wcf2VVp6ZWY27vm1dUU1KAL32WwoYbNA/8RUAog=";
  };
  arrowPlugin = pkgs.writeTextFile {
    name = "arrow.yazi";
    destination = "/init.lua";
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
    destination = "/init.lua";
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
    chmod = "${yaziPlugins}/chmod.yazi";
    diff = "${yaziPlugins}/diff.yazi";
    full-border = "${yaziPlugins}/full-border.yazi";
    git = "${yaziPlugins}/git.yazi";
    jump-to-char = "${yaziPlugins}/jump-to-char.yazi";
    parent-arrow = parentArrowPlugin;
    smart-enter = "${yaziPlugins}/smart-enter.yazi";
    smart-filter = "${yaziPlugins}/smart-filter.yazi";
  };
}
