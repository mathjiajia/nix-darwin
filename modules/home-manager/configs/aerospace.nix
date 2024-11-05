{
  home.file.aerospace = {
    target = ".config/aerospace/aerospace.toml";
    text = # toml
      ''
        start-at-login = true

        after-startup-command = [
          "exec-and-forget /run/current-system/sw/bin/borders active_color=0xff39BAE6 inactive_color=0xff494d64 width=5.0 blacklist='iPhone Mirroring'",
        ]

        [gaps]
        inner.horizontal = 10
        inner.vertical = 10
        outer.left = 10
        outer.bottom = 10
        outer.top = 10
        outer.right = 10

        [mode.main.binding]
        # cmd-shift-comma = 'reload-config'

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

        alt-1 = 'workspace 1'
        alt-2 = 'workspace Safari'
        alt-3 = 'workspace Chat'
        alt-4 = 'workspace Dev'
        alt-5 = 'workspace Finder'
        alt-6 = 'workspace Notes'
        alt-7 = 'workspace Term'
        alt-8 = 'workspace Work'
        alt-9 = 'workspace Video'

        alt-shift-1 = 'move-node-to-workspace 1'
        alt-shift-2 = 'move-node-to-workspace Safari'
        alt-shift-3 = 'move-node-to-workspace Chat'
        alt-shift-4 = 'move-node-to-workspace Dev'
        alt-shift-5 = 'move-node-to-workspace Finder'
        alt-shift-6 = 'move-node-to-workspace Notes'
        alt-shift-7 = 'move-node-to-workspace Term'
        alt-shift-8 = 'move-node-to-workspace Work'
        alt-shift-9 = 'move-node-to-workspace Video'

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
        if.app-id = 'com.apple.Safari'
        run = 'move-node-to-workspace Safari'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.edgemac'
        run = 'move-node-to-workspace Safari'

        [[on-window-detected]]
        if.app-id = 'com.tdesktop.Telegram'
        run = ['layout floating', 'move-node-to-workspace Chat']

        [[on-window-detected]]
        if.app-id = 'com.tencent.xinWeChat'
        run = ['layout floating', 'move-node-to-workspace Chat']

        [[on-window-detected]]
        if.app-id = 'com.apple.mail'
        run = ['layout floating', 'move-node-to-workspace Chat']

        [[on-window-detected]]
        if.app-id = 'net.whatsapp.WhatsApp'
        run = ['layout floating', 'move-node-to-workspace Chat']

        [[on-window-detected]]
        if.app-id = 'com.hnc.Discord'
        run = ['layout floating', 'move-node-to-workspace Chat']

        [[on-window-detected]]
        if.app-id = 'com.sublimemerge'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'com.wangchujiang.DevHub'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'dev.kdrag0n.MacVirt'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'com.apple.dt.Xcode'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.VSCode'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'dev.zed.Zed'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'com.neovide.neovide'
        run = 'move-node-to-workspace Dev'

        [[on-window-detected]]
        if.app-id = 'com.apple.finder'
        run = ['layout floating', 'move-node-to-workspace Finder']

        [[on-window-detected]]
        if.app-id = 'com.apple.Notes'
        run = ['layout floating', 'move-node-to-workspace Notes']

        [[on-window-detected]]
        if.app-id = 'com.agiletortoise.Drafts-OSX'
        run = ['layout floating', 'move-node-to-workspace Notes']

        [[on-window-detected]]
        if.app-id = 'net.sourceforge.skim-app.skim'
        run = 'move-node-to-workspace Notes'

        [[on-window-detected]]
        if.app-id = 'com.superace.updf.mac'
        run = 'move-node-to-workspace Notes'

        [[on-window-detected]]
        if.app-id = 'org.zotero.zotero'
        run = 'move-node-to-workspace Notes'

        [[on-window-detected]]
        if.app-id = 'net.kovidgoyal.kitty'
        run = 'move-node-to-workspace Term'

        [[on-window-detected]]
        if.app-id = 'com.mitchellh.ghostty'
        if.window-title-regex-substring = 'Software Update'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.mitchellh.ghostty'
        if.window-title-regex-substring = 'Updating Ghostty'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.mitchellh.ghostty'
        run = 'move-node-to-workspace Term'

        [[on-window-detected]]
        if.app-id = 'info.sioyek.sioyek'
        if.window-title-regex-substring = 'main.pdf'
        run = 'move-node-to-workspace Term'

        [[on-window-detected]]
        if.app-id = 'info.sioyek.sioyek'
        if.window-title-regex-substring = '^(?!main\.pdf$).+'
        run = 'move-node-to-workspace Notes'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Excel'
        run = 'move-node-to-workspace Work'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Powerpoint'
        run = 'move-node-to-workspace Work'

        [[on-window-detected]]
        if.app-id = 'com.microsoft.Word'
        run = 'move-node-to-workspace Work'

        [[on-window-detected]]
        if.app-id = 'com.apple.iWork.Kenotes'
        run = 'move-node-to-workspace Work'

        [[on-window-detected]]
        if.app-id = 'com.apple.iWork.Numbers'
        run = 'move-node-to-workspace Work'

        [[on-window-detected]]
        if.app-id = 'com.apple.iWork.Pages'
        run = 'move-node-to-workspace Work'

        [[on-window-detected]]
        if.app-id = 'us.zoom.xos'
        run = 'move-node-to-workspace Video'

        [[on-window-detected]]
        if.app-id = 'com.tencent.tencentmeeting'
        run = 'move-node-to-workspace Video'

        [[on-window-detected]]
        if.app-id = 'com.nssurge.surge-mac'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.openai.chat'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.apple.AppStore'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.apple.Passwords'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.noodlesoft.Hazel'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'ai.riffo.riffo'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'com.jordanbaird.Ice'
        run = 'layout floating'

        [[on-window-detected]]
        if.app-id = 'Rime.Squirrel-Designer'
        run = 'layout floating'
      '';
  };
}
