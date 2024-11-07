{pkgs, ...}: let
  yaziPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "master";
    hash = "sha256-NNfPwiY1J+s/b2rajEdAubGsGKfFCA5ALz7MNX8wyGM=";
  };
  # yaziGlow = pkgs.fetchFromGitHub {
  #   owner = "Reledia";
  #   repo = "glow.yazi";
  #   rev = "master";
  #   hash = "sha256-bqaFqjlQ/VgMdt2VVjEI8cIkA9THjOZDgNspNicxlbc=";
  # };
  # yaziMdcat = pkgs.fetchFromGitHub {
  #   owner = "GrzegorzKozub";
  #   repo = "mdcat.yazi";
  #   rev = "master";
  #   hash = "sha256-dZOOmkoyjTty1LWXobNVxicD0yrzRNzF3N0BiWz+a+E=";
  # };
  arrowPlugin = pkgs.writeTextFile {
    name = "arrow.yazi";
    destination = "/init.lua";
    text =
      # lua
      ''
        return {
          entry = function(_, args)
            local current = cx.active.current
            local new = (current.cursor + args[1]) % #current.files
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
        local function entry(_, args)
          local parent = cx.active.parent
          if not parent then
            return
          end
          local target = parent.files[parent.cursor + 1 + args[1]]
          if target and target.cha.is_dir then
            ya.manager_emit("cd", { target.url })
          end
        end
        return { entry = entry }
      '';
  };
  smartEnterPlugin = pkgs.writeTextFile {
    name = "smart-enter.yazi";
    destination = "/init.lua";
    text =
      # lua
      ''
        return {
          entry = function()
            local h = cx.active.current.hovered
            ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
          end,
        }
      '';
  };
in {
  programs.yazi.plugins = {
    arrow = arrowPlugin;
    chmod = "${yaziPlugins}/chmod.yazi";
    diff = "${yaziPlugins}/diff.yazi";
    full-border = "${yaziPlugins}/full-border.yazi";
    git = "${yaziPlugins}/git.yazi";
    # glow = yaziGlow;
    jump-to-char = "${yaziPlugins}/jump-to-char.yazi";
    # macat = yaziMdcat;
    parent-arrow = parentArrowPlugin;
    smart-enter = smartEnterPlugin;
    smart-filter = "${yaziPlugins}/smart-filter.yazi";
  };
}
