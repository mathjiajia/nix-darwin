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

        alt-1 = "workspace Chat";
        alt-2 = "workspace Dev";
        alt-3 = "workspace Finder";
        alt-4 = "workspace Notes";
        alt-5 = "workspace Safari";
        alt-6 = "workspace Term";
        alt-7 = "workspace Video";
        alt-8 = "workspace Work";
        alt-0 = "workspace Backup";

        alt-shift-1 = "move-node-to-workspace Chat";
        alt-shift-2 = "move-node-to-workspace Dev";
        alt-shift-3 = "move-node-to-workspace Finder";
        alt-shift-4 = "move-node-to-workspace Notes";
        alt-shift-5 = "move-node-to-workspace Safari";
        alt-shift-6 = "move-node-to-workspace Term";
        alt-shift-7 = "move-node-to-workspace Video";
        alt-shift-8 = "move-node-to-workspace Work";
        alt-shift-0 = "move-node-to-workspace Backup";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-semicolon = "mode service";
      };

      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"];
        f = ["layout floating tiling" "mode main"];
        backspace = ["close-all-windows-but-current" "mode main"];

        alt-shift-h = ["join-with left" "mode main"];
        alt-shift-j = ["join-with down" "mode main"];
        alt-shift-k = ["join-with up" "mode main"];
        alt-shift-l = ["join-with right" "mode main"];

        on-window-detected = [
          {
            "if".app-id = "com.apple.Safari";
            "run" = "move-node-to-workspace Safari";
          }
          {
            "if".app-id = "com.microsoft.edgemac";
            "run" = "move-node-to-workspace Safari";
          }
          {
            "if".app-id = "com.tdesktop.Telegram";
            "run" = ["layout floating" "move-node-to-workspace Chat"];
          }
          {
            "if".app-id = "com.tencent.xinWeChat";
            "run" = ["layout floating" "move-node-to-workspace Chat"];
          }
          {
            "if".app-id = "com.apple.mail";
            "run" = ["layout floating" "move-node-to-workspace Chat"];
          }
          {
            "if".app-id = "net.whatsapp.WhatsApp";
            "run" = ["layout floating" "move-node-to-workspace Chat"];
          }
          {
            "if".app-id = "com.hnc.Discord";
            "run" = ["layout floating" "move-node-to-workspace Chat"];
          }
          {
            "if".app-id = "com.sublimemerge";
            "run" = "move-node-to-workspace Dev";
          }
          {
            "if".app-id = "com.wangchujiang.DevHub";
            "run" = "move-node-to-workspace Dev";
          }
          {
            "if".app-id = "dev.kdrag0n.MacVirt";
            "run" = "move-node-to-workspace Dev";
          }
          {
            "if".app-id = "com.apple.dt.Xcode";
            "run" = "move-node-to-workspace Dev";
          }
          {
            "if".app-id = "com.microsoft.VSCode";
            "run" = "move-node-to-workspace Dev";
          }
          {
            "if".app-id = "dev.zed.Zed";
            "run" = "move-node-to-workspace Dev";
          }
          {
            "if".app-id = "com.apple.finder";
            "run" = ["layout floating" "move-node-to-workspace Finder"];
          }

          {
            "if".app-id = "com.apple.Notes";
            "run" = ["layout floating" "move-node-to-workspace Notes"];
          }
          {
            "if".app-id = "com.agiletortoise.Drafts-OSX";
            "run" = ["layout floating" "move-node-to-workspace Notes"];
          }
          {
            "if".app-id = "net.sourceforge.skim-app.skim";
            "run" = "move-node-to-workspace Notes";
          }
          {
            "if".app-id = "com.superace.updf.mac";
            "run" = "move-node-to-workspace Notes";
          }
          {
            "if".app-id = "org.zotero.zotero";
            "run" = "move-node-to-workspace Notes";
          }
          {
            "if".app-id = "com.mitchellh.ghostty";
            "if".window-title-regex-substring = "Software Update";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.mitchellh.ghostty";
            "if".window-title-regex-substring = "Updating Ghostty";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.mitchellh.ghostty";
            "run" = "move-node-to-workspace Term";
          }
          {
            "if".app-id = "info.sioyek.sioyek";
            "if".window-title-regex-substring = "main.pdf";
            "run" = "move-node-to-workspace Term";
          }
          {
            "if".app-id = "info.sioyek.sioyek";
            "if".window-title-regex-substring = "^(?!main\.pdf$).+";
            "run" = "move-node-to-workspace Notes";
          }
          {
            "if".app-id = "com.microsoft.Excel";
            "run" = "move-node-to-workspace Work";
          }
          {
            "if".app-id = "com.microsoft.Powerpoint";
            "run" = "move-node-to-workspace Work";
          }
          {
            "if".app-id = "com.microsoft.Word";
            "run" = "move-node-to-workspace Work";
          }
          {
            "if".app-id = "com.apple.iWork.Kenotes";
            "run" = "move-node-to-workspace Work";
          }
          {
            "if".app-id = "com.apple.iWork.Numbers";
            "run" = "move-node-to-workspace Work";
          }
          {
            "if".app-id = "com.apple.iWork.Pages";
            "run" = "move-node-to-workspace Work";
          }
          {
            "if".app-id = "us.zoom.xos";
            "run" = "move-node-to-workspace Video";
          }
          {
            "if".app-id = "com.tencent.tencentmeeting";
            "run" = "move-node-to-workspace Video";
          }
          {
            "if".app-id = "com.nssurge.surge-mac";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.openai.chat";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.apple.AppStore";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.apple.Passwords";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.noodlesoft.Hazel";
            "run" = "layout floating";
          }
          {
            "if".app-id = "ai.riffo.riffo";
            "run" = "layout floating";
          }
          {
            "if".app-id = "com.jordanbaird.Ice";
            "run" = "layout floating";
          }
        ];
      };
    };
  };
}
