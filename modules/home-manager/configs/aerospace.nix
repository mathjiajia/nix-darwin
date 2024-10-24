{ ... }:
{
  home.file.aerospace = {
    target = ".config/aerospace/aerospace.toml";
    text = # toml
      ''
        start-at-login = true

        [gaps]
        inner.horizontal = 10
        inner.vertical = 10
        outer.left = 10
        outer.bottom = 10
        outer.top = 10
        outer.right = 10

        [mode.main.binding]
        alt-enter = 'exec-and-forget open -n /Applications/Ghostty.app'

        cmd-shift-comma = 'reload-config'

        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        alt-slash = 'layout tiles horizontal vertical'
        alt-comma = 'layout accordion horizontal vertical'

        # See: https://nikitabobko.github.io/AeroSpace/commands#focus
        alt-h = 'focus left'
        alt-j = 'focus down'
        alt-k = 'focus up'
        alt-l = 'focus right'

        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        alt-shift-h = 'move left'
        alt-shift-j = 'move down'
        alt-shift-k = 'move up'
        alt-shift-l = 'move right'

        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-shift-minus = 'resize smart -50'
        alt-shift-equal = 'resize smart +50'

        # Not supported, because this command is redundant in AeroSpace mental model.
        # See: https://nikitabobko.github.io/AeroSpace/guide.html#floating-windows
        #alt-space = 'focus toggle_tiling_floating'

        # `focus parent`/`focus child` are not yet supported, and it's not clear whether they
        # should be supported at all https://github.com/nikitabobko/AeroSpace/issues/5
        # alt-a = 'focus parent'

        alt-1 = 'workspace 🍏'
        # Z - zoom and voov
        alt-2 = 'workspace 🎬'
        alt-z = 'workspace 🎬'
        # W - work
        alt-3 = 'workspace 🏫'
        alt-w = 'workspace 🏫'
        # T - terminal
        alt-4 = 'workspace 👻'
        alt-t = 'workspace 👻'
        # C - chat
        alt-5 = 'workspace 💬'
        alt-c = 'workspace 💬'
        # F - finder
        alt-6 = 'workspace 📁'
        alt-f = 'workspace 📁'
        # N - notes
        alt-7 = 'workspace 📔'
        alt-n = 'workspace 📔'
        # B - browser
        alt-8 = 'workspace 🔍'
        alt-b = 'workspace 🔍'
        # D -  devtools
        alt-9 = 'workspace 🧑‍💻'
        alt-d = 'workspace 🧑‍💻'

        alt-shift-1 = 'move-node-to-workspace 🍏'
        alt-shift-2 = 'move-node-to-workspace 🎬'
        alt-shift-3 = 'move-node-to-workspace 🏫'
        alt-shift-4 = 'move-node-to-workspace 👻'
        alt-shift-5 = 'move-node-to-workspace 💬'
        alt-shift-6 = 'move-node-to-workspace 📁'
        alt-shift-7 = 'move-node-to-workspace 📔'
        alt-shift-8 = 'move-node-to-workspace 🔍'
        alt-shift-9 = 'move-node-to-workspace 🧑‍💻'

        alt-tab = 'workspace-back-and-forth'
        alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

        alt-shift-semicolon = 'mode service'

        [mode.service.binding]
        esc = ['reload-config', 'mode main']
        r = ['flatten-workspace-tree', 'mode main']
        f = ['layout floating tiling', 'mode main']
        backspace = ['close-all-windows-but-current', 'mode main']

        # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
        #s = ['layout sticky tiling', 'mode main']

        alt-shift-h = ['join-with left', 'mode main']
        alt-shift-j = ['join-with down', 'mode main']
        alt-shift-k = ['join-with up', 'mode main']
        alt-shift-l = ['join-with right', 'mode main']

        [[on-window-detected]]
        if.app-id = 'us.zoom.xos'
        run = 'move-node-to-workspace 🎬'

        [[on-window-detected]]
        if.app-id = 'com.tencent.tencentmeeting'
        run = 'move-node-to-workspace 🎬'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Excel'
        run = 'move-node-to-workspace 🏫'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Powerpoint'
        run = 'move-node-to-workspace 🏫'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Word'
        run = 'move-node-to-workspace 🏫'

        [[on-window-detected]]
        if.app-id = 'com.apple.iWork.Kenotes'
        run = 'move-node-to-workspace 🏫'

        [[on-window-detected]]
        if.app-id = 'com.apple.iWork.Numbers'
        run = 'move-node-to-workspace 🏫'

        [[on-window-detected]]
        if.app-id = 'com.apple.iWork.Pages'
        run = 'move-node-to-workspace 🏫'
        [[on-window-detected]]
        if.app-id = 'net.kovidgoyal.kitty'
        run = 'move-node-to-workspace 👻'

        [[on-window-detected]]
        if.app-id = 'com.mitchellh.ghostty'
        run = 'move-node-to-workspace 👻'

        [[on-window-detected]]
        if.app-id = 'info.sioyek.sioyek'
        run = 'move-node-to-workspace 👻'

        [[on-window-detected]]
        if.app-id = 'com.tdesktop.Telegram'
        run = 'move-node-to-workspace 💬'

        [[on-window-detected]]
        if.app-id = 'com.tencent.xinWeChat'
        run = 'move-node-to-workspace 💬'

        [[on-window-detected]]
        if.app-id = 'com.apple.mail'
        run = 'move-node-to-workspace 💬'

        [[on-window-detected]]
        if.app-id = 'net.whatsapp.WhatsApp'
        run = 'move-node-to-workspace 💬'

        [[on-window-detected]]
        if.app-id = 'com.hnc.Discord'
        run = 'move-node-to-workspace 💬'

        [[on-window-detected]]
        if.app-id = 'com.apple.finder'
        run = 'move-node-to-workspace 📁'

        [[on-window-detected]]
        if.app-id = 'com.apple.Notes'
        run = 'move-node-to-workspace 📔'

        [[on-window-detected]]
        if.app-id = 'com.superace.updf.mac'
        run = 'move-node-to-workspace 📔'

        [[on-window-detected]]
        if.app-id = 'org.zotero.zotero'
        run = 'move-node-to-workspace 📔'

        [[on-window-detected]]
        if.app-id = 'com.apple.Safari'
        run = 'move-node-to-workspace 🔍'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.edgemac'
        run = 'move-node-to-workspace 🔍'

        [[on-window-detected]]
        if.app-id = 'com.sublimemerge'
        run = 'move-node-to-workspace 🧑‍💻'

        [[on-window-detected]]
        if.app-id = 'com.wangchujiang.DevHub'
        run = 'move-node-to-workspace 🧑‍💻'

        [[on-window-detected]]
        if.app-id = 'dev.kdrag0n.MacVirt'
        run = 'move-node-to-workspace 🧑‍💻'

        [[on-window-detected]]
        if.app-id = 'com.apple.dt.Xcode'
        run = 'move-node-to-workspace 🧑‍💻'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.VSCode'
        run = 'move-node-to-workspace 🧑‍💻'

        [[on-window-detected]]
        if.app-id = 'dev.zed.Zed'
        run = 'move-node-to-workspace 🧑‍💻'

        [[on-window-detected]]
        if.app-id = 'com.neovide.neovide'
        run = 'move-node-to-workspace 🧑‍💻'
      '';
  };
}
