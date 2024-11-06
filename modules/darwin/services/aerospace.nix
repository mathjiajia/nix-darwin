{
  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        oute.right = 8;
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
        alt-2 = "workspace Chat";
        alt-3 = "workspace Dev";
        alt-4 = "workspace Finder";
        alt-5 = "workspace Notes";
        alt-6 = "workspace Safari";
        alt-7 = "workspace Term";
        alt-8 = "workspace Video";
        alt-9 = "workspace Work";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace Chat";
        alt-shift-3 = "move-node-to-workspace Dev";
        alt-shift-4 = "move-node-to-workspace Finder";
        alt-shift-5 = "move-node-to-workspace Notes";
        alt-shift-6 = "move-node-to-workspace Safari";
        alt-shift-7 = "move-node-to-workspace Term";
        alt-shift-8 = "move-node-to-workspace Video";
        alt-shift-9 = "move-node-to-workspace Work";

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

        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];

        on-window-detected = {

        };
      };
    };
  };
}
