{
  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
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

        alt-1 = "workspace 􁓘1";
        alt-2 = "workspace 􀤆B";
        alt-3 = "workspace 􀌤C";
        alt-4 = "workspace 􀫊D";
        alt-5 = "workspace 􀈕F";
        alt-6 = "workspace 􁜾N";
        alt-7 = "workspace 􀩼T";
        alt-8 = "workspace 􀍉V";
        alt-9 = "workspace 􀈟W";
        alt-0 = "workspace 􁓘0";

        alt-shift-1 = "move-node-to-workspace 􁓘1";
        alt-shift-2 = "move-node-to-workspace 􀤆B";
        alt-shift-3 = "move-node-to-workspace 􀌤C";
        alt-shift-4 = "move-node-to-workspace 􀫊D";
        alt-shift-5 = "move-node-to-workspace 􀈕F";
        alt-shift-6 = "move-node-to-workspace 􁜾N";
        alt-shift-7 = "move-node-to-workspace 􀩼T";
        alt-shift-8 = "move-node-to-workspace 􀍉V";
        alt-shift-9 = "move-node-to-workspace 􀈟W";
        alt-shift-0 = "move-node-to-workspace 􁓘0";

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
      };
      on-window-detected = [
        {
          "if".app-id = "com.apple.Safari";
          run = "move-node-to-workspace 􀤆B";
        }
        {
          "if".app-id = "com.microsoft.edgemac";
          run = "move-node-to-workspace 􀤆B";
        }
        {
          "if".app-id = "com.tdesktop.Telegram";
          run = ["layout floating" "move-node-to-workspace 􀌤C"];
        }
        {
          "if".app-id = "com.tencent.xinWeChat";
          run = ["layout floating" "move-node-to-workspace 􀌤C"];
        }
        {
          "if".app-id = "com.apple.mail";
          run = ["layout floating" "move-node-to-workspace 􀌤C"];
        }
        {
          "if".app-id = "net.whatsapp.WhatsApp";
          run = ["layout floating" "move-node-to-workspace 􀌤C"];
        }
        {
          "if".app-id = "com.hnc.Discord";
          run = ["layout floating" "move-node-to-workspace 􀌤C"];
        }
        {
          "if".app-id = "com.sublimemerge";
          run = "move-node-to-workspace 􀫊D";
        }
        {
          "if".app-id = "com.wangchujiang.DevHub";
          run = "move-node-to-workspace 􀫊D";
        }
        {
          "if".app-id = "dev.kdrag0n.MacVirt";
          run = "move-node-to-workspace 􀫊D";
        }
        {
          "if".app-id = "com.apple.dt.Xcode";
          run = "move-node-to-workspace 􀫊D";
        }
        {
          "if".app-id = "com.microsoft.VSCode";
          run = "move-node-to-workspace 􀫊D";
        }
        {
          "if".app-id = "dev.zed.Zed";
          run = "move-node-to-workspace 􀫊D";
        }
        {
          "if".app-id = "com.apple.finder";
          run = ["layout floating" "move-node-to-workspace 􀈕F"];
        }

        {
          "if".app-id = "com.apple.Notes";
          run = ["layout floating" "move-node-to-workspace 􁜾N"];
        }
        {
          "if".app-id = "com.agiletortoise.Drafts-OSX";
          run = ["layout floating" "move-node-to-workspace 􁜾N"];
        }
        {
          "if".app-id = "net.sourceforge.skim-app.skim";
          run = "move-node-to-workspace 􁜾N";
        }
        {
          "if".app-id = "com.superace.updf.mac";
          run = "move-node-to-workspace 􁜾N";
        }
        {
          "if" = {
            app-id = "org.zotero.zotero";
            window-title-regex-substring = "^(?!.* - Zotero$).*";
          };
          run = "layout floating";
        }
        {
          "if".app-id = "org.zotero.zotero";
          run = "move-node-to-workspace 􁜾N";
        }
        {
          "if" = {
            app-id = "com.mitchellh.ghostty";
            window-title-regex-substring = "(Software Update|Updating Ghostty)";
          };
          run = "layout floating";
        }
        {
          "if".app-id = "com.mitchellh.ghostty";
          run = "move-node-to-workspace 􀩼T";
        }
        {
          "if".app-id = "net.kovidgoyal.kitty";
          run = "move-node-to-workspace 􀩼T";
        }
        {
          "if".app-id = "info.sioyek.sioyek";
          run = "move-node-to-workspace 􀩼T";
        }
        {
          "if".app-id = "com.microsoft.Excel";
          run = "move-node-to-workspace 􀈟W";
        }
        {
          "if".app-id = "com.microsoft.Powerpoint";
          run = "move-node-to-workspace 􀈟W";
        }
        {
          "if".app-id = "com.microsoft.Word";
          run = "move-node-to-workspace 􀈟W";
        }
        {
          "if".app-id = "com.apple.iWork.Kenotes";
          run = "move-node-to-workspace 􀈟W";
        }
        {
          "if".app-id = "com.apple.iWork.Numbers";
          run = "move-node-to-workspace 􀈟W";
        }
        {
          "if".app-id = "com.apple.iWork.Pages";
          run = "move-node-to-workspace 􀈟W";
        }
        {
          "if".app-id = "us.zoom.xos";
          run = "move-node-to-workspace 􀍉V";
        }
        {
          "if".app-id = "com.tencent.tencentmeeting";
          run = "move-node-to-workspace 􀍉V";
        }
        {
          "if".app-id = "com.nssurge.surge-mac";
          run = "layout floating";
        }
        {
          "if".app-id = "com.nssurge.surge-dashboard";
          run = "layout floating";
        }
        {
          "if".app-id = "com.openai.chat";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.AppStore";
          run = "layout floating";
        }
        {
          "if".app-id = "com.apple.Passwords";
          run = "layout floating";
        }
        {
          "if".app-id = "com.noodlesoft.Hazel";
          run = "layout floating";
        }
        {
          "if".app-id = "ai.riffo.riffo";
          run = "layout floating";
        }
        {
          "if".app-id = "com.jordanbaird.Ice";
          run = "layout floating";
        }
        {
          "if".app-id = "org.fcitx.inputmethod.Fcitx5";
          run = "layout floating";
        }
        {
          "if".app-id = "com.aone.keka";
          run = "layout floating";
        }
      ];
    };
  };
}
