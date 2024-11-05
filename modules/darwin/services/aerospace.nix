{
  services = {
    aerospace = {
      enable = true;
      settings = {
        after-login-command = [
          "exec-and-forget /run/current-system/sw/bin/borders active_color=0xff39BAE6 inactive_color=0xff494d64 width=5.0 blacklist='iPhone Mirroring'"
        ];

        gaps.inner = {
          horizontal = 8;
          vertical = 8;
        };
        gaps.outer = {
          left = 8;
          bottom = 8;
          top = 8;
          right = 8;
        };

        mode.main.binding = {
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-shift-minus = "resize smart -50";
          alt-shift-equal = "resize smart +50";

          alt-1 = "workspace 1";
          alt-2 = "workspace Safari";
          alt-3 = "workspace Chat";
          alt-4 = "workspace Dev";
          alt-5 = "workspace Finder";
          alt-6 = "workspace Notes";
          alt-7 = "workspace Term";
          alt-8 = "workspace Work";
          alt-9 = "workspace Video";

          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace Safari";
          alt-shift-3 = "move-node-to-workspace Chat";
          alt-shift-4 = "move-node-to-workspace Dev";
          alt-shift-5 = "move-node-to-workspace Finder";
          alt-shift-6 = "move-node-to-workspace Notes";
          alt-shift-7 = "move-node-to-workspace Term";
          alt-shift-8 = "move-node-to-workspace Work";
          alt-shift-9 = "move-node-to-workspace Video";

          alt-tab = "workspace-back-and-forth";
          alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

          alt-shift-semicolon = "mode service";

        };

        mode.service.binding = {
          esc = [
            "reload-config"
            "mode main"
          ];
          r = [
            "flatten-workspace-tree"
            "mode main"
          ];
          f = [
            "layout floating tiling"
            "mode main"
          ];
          backspace = [
            "close-all-windows-but-current"
            "mode main"
          ];
        };
      };
    };
  };
}
