---@meta _

-- Editor definitions only; do not require this file from init.lua.
-- Lua API: https://www.superlogical.com/rex/docs/reference/lua
-- Session and terminal shapes checked against Rex 0.1.0-preview.15, API revision 13.

---@class rex: rex.Server
---@field bind        fun(key: string, action: string | rex.KeyHandler, args?: table)                              Config only; named actions are bound at load time.
---@field unbind      fun(key: string | rex.Binding | { mode: string }, target?: string | rex.KeyHandler): integer Config only.
---@field mode        fun(name: string, options?: { exclusive?: boolean })                                         Config at load time.
---@field bindings    fun(filter?: { key?: string, mode?: string, action?: string }): rex.Binding[]                Config at load time.
---@field modes       fun(): rex.Mode[]                                                                            Config at load time.
---@field action      fun(action: rex.Action)                                                                      Define an action while loading a config or script.
---@field invoke      fun(name: string, args?: table): any, string?                                                Run an action; the second result is an error message.
---@field client      rex.Client
---@field layout      rex.LayoutBuilder
---@field host        fun(host: rex.Host)                                                                          Config at load time.
---@field servers     fun(): string[]
---@field server      fun(label: string): rex.Server                                                               Remote calls need explicit session and block IDs.
---@field exec        rex.Exec
---@field json        rex.Json
---@field log         fun(level_or_message: rex.LogLevel | string, message?: string)                               With one argument, the level is info.
---@field on          rex.On                                                                                       Script only.
---@field wait        rex.Wait                                                                                     Script only; timeout is in seconds.
---@field sleep       fun(seconds: number)                                                                         Script only.
---@field stop        fun(code?: integer)                                                                          Script only; exits immediately, defaulting to status 0.
---@field after       fun(seconds: number, callback: fun(ctx: rex.Context)): rex.Timer                             Script only; runs once.
---@field every       fun(seconds: number, callback: fun(ctx: rex.Context)): rex.Timer                             Script only; repeats until cancelled.
---@field args        table<string, any>                                                                           Script only; absent in init.lua.
---@field session_id? string                                                                                       Script only.
---@field block_id?   string                                                                                       Script only; absent without a target block.

---@class rex.Server
---@field session rex.Session
---@field block   rex.Block
---@field call    fun(method: string, args?: table): table?, string? API failures return nil and an error message.

---@class rex.Client
---@field queue fun(name: string, args?: table) In a config action, runs after the action succeeds; immediate in scripts.

---@class rex.Context
---@field session_id? string
---@field block_id?   string
---@field client_id?  string
---@field origin?     string For example, script or timer.
---@field server?     any    Server context, when supplied by Rex.

---@alias rex.KeyHandler fun(ctx: rex.Context, ev: rex.KeyEvent): boolean?

---@class rex.KeyEvent
---@field keybinding string
---@field prefix?    string

---@class rex.Binding
---@field key     string
---@field mode?   string
---@field action? string
---@field fn?     rex.KeyHandler
---@field args?   table
---@field source  string

---@class rex.Mode
---@field name      string
---@field exclusive boolean
---@field source    string

---@alias rex.ArgType "string" | "number" | "integer" | "boolean" | "object" | "array" | "any" | "string?" | "number?" | "integer?" | "boolean?" | "object?" | "array?" | "any?"

---@class rex.Action
---@field name         string
---@field title        string
---@field run          fun(ctx: rex.Context, args: table<string, any>): any
---@field description? string
---@field category?    string                                               Defaults to Actions.
---@field keywords?    string
---@field args?        table<string, rex.ArgType> | table                   Argument shorthand or a JSON Schema.
---@field repeats?     boolean

---@class rex.HostConfig
---@field label string
---@field id?   string
---@field icon? string

---@class rex.HostEndpoints: rex.HostConfig
---@field endpoints string[] Addresses tried in order.

---@class rex.HostEndpoint: rex.HostConfig
---@field endpoint string

---@alias rex.Host rex.HostEndpoints|rex.HostEndpoint
---@alias rex.LogLevel "debug"|"info"|"warn"|"error"
---@alias rex.Direction "horizontal"|"vertical"
---@alias rex.Side "before"|"after"

-- Bounds are fractions of the window: { x, y, width, height }, from the top left.
-- For a centered 90% float, use { 0.05, 0.05, 0.9, 0.9 }.
---@alias rex.Bounds [number, number, number, number] | { x: number, y: number, w: number, h: number }

---@class rex.BlockSpec
---@field flavor   string                      For example, com.superlogical.terminal.shell.
---@field label?   string
---@field options? rex.TerminalOptions | table Options depend on the flavor.

---@alias rex.Layout rex.BlockLayout | rex.SplitLayout

---@class rex.BlockLayout
---@field block rex.BlockSpec

---@class rex.SplitLayout
---@field split rex.SplitSpec

---@class rex.SplitSpec
---@field direction rex.Direction
---@field ratio?    number        Share given to before, between 0 and 1; defaults to 0.5.
---@field before    rex.Layout
---@field after     rex.Layout

---@class rex.LayoutBuilder
---@field block      fun(spec: rex.BlockSpec): rex.BlockLayout
---@field horizontal fun(ratio: number, before: rex.Layout, after: rex.Layout): rex.SplitLayout
---@field vertical   fun(ratio: number, before: rex.Layout, after: rex.Layout): rex.SplitLayout

---@class rex.ExecOptions
---@field cwd?       string
---@field env?       table<string, string | false> false removes a variable.
---@field clear_env? boolean
---@field stdin?     string
---@field timeout?   number                        Seconds before SIGTERM, followed by SIGKILL after two more seconds.
---@field stdout?    boolean                       false discards output; otherwise it is captured.
---@field stderr?    boolean
---@field text?      boolean                       false preserves CRLF on Windows.

---@class rex.ExecStartOptions
---@field cwd?       string
---@field env?       table<string, string | false>
---@field clear_env? boolean
---@field stdin?     string | true                 true keeps stdin open for handle:write().
---@field timeout?   number
---@field stdout?    boolean | fun(data: string)   Callback chunks may end mid-line.
---@field stderr?    boolean | fun(data: string)
---@field text?      boolean
---@field detach?    boolean                       Let the process outlive the action, handler, timer, or script that started it.

---@class rex.ExecResult
---@field code      integer - 1 when terminated by a signal.
---@field signal?   string
---@field stdout    string
---@field stderr    string
---@field timed_out boolean
---@field ok        boolean     True for exit code 0 without a timeout.

---@class rex.Exec
---@overload fun(argv: string[], opts?: rex.ExecOptions): rex.ExecResult?, string?
---@field start fun(argv: string[], opts?: rex.ExecStartOptions): rex.ProcessHandle?, string?

---@class rex.ProcessHandle
---@field pid         integer
---@field wait        fun(self: rex.ProcessHandle, seconds?: number): rex.ExecResult?, string? A wait timeout does not kill the process.
---@field write       fun(self: rex.ProcessHandle, data: string): true?, string?
---@field close_stdin fun(self: rex.ProcessHandle)
---@field kill        fun(self: rex.ProcessHandle, signal?: string | integer)                  Defaults to SIGTERM.
---@field running     fun(self: rex.ProcessHandle): boolean

---@class rex.Timer
---@field cancel fun(self: rex.Timer)
---@field active fun(self: rex.Timer): boolean

---@class rex.Json
---@field encode fun(value: any, opts?: { indent?: boolean }): string?, string?
---@field decode fun(text: string): any, string?                                JSON null becomes nil.

-- Event names remain open to plugins and future Rex versions.
---@alias rex.EventName string
--- |     "window_created"
--- |     "window_closed"
--- |     "window_label_changed"
--- |     "active_window_changed"
--- |     "block_created"
--- |     "block_closed"
--- |     "session_label_changed"
--- |     "session_view_changed"
--- |     "client_connected"
--- |     "client_disconnected"
--- |     "client_connection_changed"
--- |     "creator_changed"
--- |     "block_event"
--- |     "terminal.child_exited"
--- |     "terminal.pwd_changed"
--- |     "terminal.title_changed"
--- |     "terminal.bell"
--- |     "terminal.process_changed"
--- |     "terminal.desktop_notification"
--- |     "terminal.progress_report"
--- |     "terminal.clipboard_written"
--- |     "terminal.program_status_changed"
--- |     "terminal.program_status_removed"
--- |     "session_created"
--- |     "session_destroyed"
--- |     "client_joined"
--- |     "client_left"
--- |     "client_changed"
--- |     "keymap_changed"
--- |     "hosts_changed"
--- |     "tailscale_status_changed"

---@class rex.Event: { [string]: any }
---@field type          string Terminal events have type block_event.
---@field session_id?   string
---@field payload       table  Event-specific fields are also available directly on the event.
---@field block_id?     string
---@field creator_name? string
---@field name?         string Block event name without the creator prefix.

-- Session methods fill session_id from the action or script context.
-- Other IDs must be supplied explicitly. Remote server handles fill in no IDs.
---@class rex.Session
---@field view                  fun(args: rex.session.Args): rex.SessionView?, string?
---@field list_blocks           fun(args: rex.session.Args): rex.session.ListBlocksResult?, string?
---@field list_clients          fun(args: rex.session.Args): rex.session.ListClientsResult?, string?
---@field describe_block        fun(args: rex.session.BlockArgs): rex.session.DescribeBlockResult?, string?
---@field new_window            fun(args: rex.session.NewWindowArgs): rex.session.NewWindowResult?, string?
---@field new_split             fun(args: rex.session.NewSplitArgs): rex.session.NewSplitResult?, string?
---@field new_block             fun(args: rex.session.NewBlockArgs): rex.session.NewBlockResult?, string?
---@field new_layer             fun(args: rex.session.NewLayerArgs): rex.session.NewLayerResult?, string?
---@field close_window          fun(args: rex.session.CloseWindowArgs): rex.Revision?, string?
---@field close_layer           fun(args: rex.session.LayerArgs): rex.Revision?, string?
---@field move_block            fun(args: rex.session.MoveBlockArgs): rex.session.MoveBlockResult?, string?
---@field swap_blocks           fun(args: rex.session.SwapBlocksArgs): rex.Revision?, string?
---@field detach_block          fun(args: rex.session.BlockArgs): rex.Revision?, string?
---@field float_block           fun(args: rex.session.FloatBlockArgs): rex.session.FloatBlockResult?, string?
---@field zoom_block            fun(args: rex.session.ZoomBlockArgs): rex.session.ZoomBlockResult?, string?
---@field resize_pane           fun(args: rex.session.ResizePaneArgs): rex.Revision?, string?
---@field resize_layer          fun(args: rex.session.ResizeLayerArgs): rex.Revision?, string?
---@field raise_layer           fun(args: rex.session.LayerOrderArgs): rex.Revision?, string?
---@field lower_layer           fun(args: rex.session.LayerOrderArgs): rex.Revision?, string?
---@field move_window           fun(args: rex.session.MoveWindowArgs): rex.Revision?, string?
---@field focus_block           fun(args: rex.session.BlockArgs): rex.Revision?, string?
---@field focus_window          fun(args: rex.session.WindowArgs): rex.Revision?, string?
---@field focus_direction       fun(args: rex.session.FocusDirectionArgs): rex.Revision?, string?
---@field focus_next_pane       fun(args: rex.session.FocusCycleArgs): rex.Revision?, string?
---@field focus_previous_pane   fun(args: rex.session.FocusCycleArgs): rex.Revision?, string?
---@field focus_next_window     fun(args: rex.session.FocusCycleArgs): rex.Revision?, string?
---@field focus_previous_window fun(args: rex.session.FocusCycleArgs): rex.Revision?, string?
---@field set_label             fun(args: rex.session.SetLabelArgs): rex.Revision?, string?
---@field set_window_label      fun(args: rex.session.SetWindowLabelArgs): rex.Revision?, string?
---@field set_block_label       fun(args: rex.session.SetBlockLabelArgs): rex.Revision?, string?
---@field attach                fun(args: rex.session.Args): rex.session.AttachResult?, string?
---@field detach                fun(args: rex.session.Args): table?, string?
---@field help                  fun(args: rex.session.Args): table?, string?

-- Block calls fill session_id and block_id from the current context.
-- Method parameters go inside args: { block_id = id, args = { data = "hello" } }.
---@class rex.Block
---@field call rex.BlockCall

---@class rex.BlockCall
---@overload fun(creator: "com.superlogical.terminal", method: "format", args?: rex.terminal.FormatCall): rex.terminal.FormatResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "process", args?: rex.terminal.CallArgs): rex.terminal.ProcessResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "pwd", args?: rex.terminal.CallArgs): rex.terminal.PwdResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "title", args?: rex.terminal.CallArgs): rex.terminal.TitleResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "size", args?: rex.terminal.CallArgs): rex.terminal.SizeResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "write", args: rex.terminal.WriteCall): rex.terminal.WriteResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "reset", args?: rex.terminal.CallArgs): table?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "resize", args: rex.terminal.ResizeCall): table?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "set_theme", args?: rex.terminal.SetThemeCall): table?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "program_status", args?: rex.terminal.CallArgs): rex.terminal.ProgramStatusResult?, string?
---@overload fun(creator: "com.superlogical.terminal", method: "list_dir", args?: rex.terminal.ListDirCall): rex.terminal.ListDirResult?, string?
---@overload fun(creator: string, method: string, args?: table): table?, string?

---@class rex.On
---@overload fun(event: "terminal.bell" | "com.superlogical.terminal.bell", handler: fun(ctx: rex.Context, ev: rex.terminal.BellEvent))
---@overload fun(event: "terminal.child_exited" | "com.superlogical.terminal.child_exited", handler: fun(ctx: rex.Context, ev: rex.terminal.ChildExitedEvent))
---@overload fun(event: "terminal.clipboard_written" | "com.superlogical.terminal.clipboard_written", handler: fun(ctx: rex.Context, ev: rex.terminal.ClipboardWrittenEvent))
---@overload fun(event: "terminal.desktop_notification" | "com.superlogical.terminal.desktop_notification", handler: fun(ctx: rex.Context, ev: rex.terminal.DesktopNotificationEvent))
---@overload fun(event: "terminal.process_changed" | "com.superlogical.terminal.process_changed", handler: fun(ctx: rex.Context, ev: rex.terminal.ProcessChangedEvent))
---@overload fun(event: "terminal.program_status_changed" | "com.superlogical.terminal.program_status_changed", handler: fun(ctx: rex.Context, ev: rex.terminal.ProgramStatusChangedEvent))
---@overload fun(event: "terminal.program_status_removed" | "com.superlogical.terminal.program_status_removed", handler: fun(ctx: rex.Context, ev: rex.terminal.ProgramStatusRemovedEvent))
---@overload fun(event: "terminal.progress_report" | "com.superlogical.terminal.progress_report", handler: fun(ctx: rex.Context, ev: rex.terminal.ProgressReportEvent))
---@overload fun(event: "terminal.pwd_changed" | "com.superlogical.terminal.pwd_changed", handler: fun(ctx: rex.Context, ev: rex.terminal.PwdChangedEvent))
---@overload fun(event: "terminal.selection_copied" | "com.superlogical.terminal.selection_copied", handler: fun(ctx: rex.Context, ev: rex.terminal.SelectionCopiedEvent))
---@overload fun(event: "terminal.size_changed" | "com.superlogical.terminal.size_changed", handler: fun(ctx: rex.Context, ev: rex.terminal.SizeChangedEvent))
---@overload fun(event: "terminal.title_changed" | "com.superlogical.terminal.title_changed", handler: fun(ctx: rex.Context, ev: rex.terminal.TitleChangedEvent))
---@overload fun(event: "terminal.url_clicked" | "com.superlogical.terminal.url_clicked", handler: fun(ctx: rex.Context, ev: rex.terminal.UrlClickedEvent))
---@overload fun(event: rex.EventName, handler: fun(ctx: rex.Context, ev: rex.Event))

---@class rex.Wait
---@overload fun(event: "terminal.bell" | "com.superlogical.terminal.bell", filter?: table | (fun(ev: rex.terminal.BellEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.BellEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.child_exited" | "com.superlogical.terminal.child_exited", filter?: table | (fun(ev: rex.terminal.ChildExitedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.ChildExitedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.clipboard_written" | "com.superlogical.terminal.clipboard_written", filter?: table | (fun(ev: rex.terminal.ClipboardWrittenEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.ClipboardWrittenEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.desktop_notification" | "com.superlogical.terminal.desktop_notification", filter?: table | (fun(ev: rex.terminal.DesktopNotificationEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.DesktopNotificationEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.process_changed" | "com.superlogical.terminal.process_changed", filter?: table | (fun(ev: rex.terminal.ProcessChangedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.ProcessChangedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.program_status_changed" | "com.superlogical.terminal.program_status_changed", filter?: table | (fun(ev: rex.terminal.ProgramStatusChangedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.ProgramStatusChangedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.program_status_removed" | "com.superlogical.terminal.program_status_removed", filter?: table | (fun(ev: rex.terminal.ProgramStatusRemovedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.ProgramStatusRemovedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.progress_report" | "com.superlogical.terminal.progress_report", filter?: table | (fun(ev: rex.terminal.ProgressReportEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.ProgressReportEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.pwd_changed" | "com.superlogical.terminal.pwd_changed", filter?: table | (fun(ev: rex.terminal.PwdChangedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.PwdChangedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.selection_copied" | "com.superlogical.terminal.selection_copied", filter?: table | (fun(ev: rex.terminal.SelectionCopiedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.SelectionCopiedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.size_changed" | "com.superlogical.terminal.size_changed", filter?: table | (fun(ev: rex.terminal.SizeChangedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.SizeChangedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.title_changed" | "com.superlogical.terminal.title_changed", filter?: table | (fun(ev: rex.terminal.TitleChangedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.TitleChangedEvent?, rex.Context | "timeout"
---@overload fun(event: "terminal.url_clicked" | "com.superlogical.terminal.url_clicked", filter?: table | (fun(ev: rex.terminal.UrlClickedEvent, ctx: rex.Context): boolean), timeout?: number): rex.terminal.UrlClickedEvent?, rex.Context | "timeout"
---@overload fun(event: rex.EventName, filter?: table | (fun(ev: rex.Event, ctx: rex.Context): boolean), timeout?: number): rex.Event?, rex.Context | "timeout"

---@class rex.terminal.BellEvent: rex.Event

---@class rex.terminal.ChildExitedEvent: rex.Event
---@field exit_code integer
---@field error?    string

---@class rex.terminal.ClipboardWrittenEvent: rex.Event
---@field text?  string
---@field id?    integer
---@field bytes? integer

---@class rex.terminal.DesktopNotificationEvent: rex.Event
---@field title string
---@field body  string

---@class rex.terminal.ProcessChangedEvent: rex.Event
---@field generation  integer
---@field foreground? rex.ProcessInfo
---@field ancestors?  rex.ProcessInfo[]

---@class rex.terminal.ProgramStatusChangedEvent: rex.Event
---@field id     string
---@field record rex.ProgramStatus
---@field reason string

---@class rex.terminal.ProgramStatusRemovedEvent: rex.Event
---@field ids    string[]
---@field reason string

---@class rex.terminal.ProgressReportEvent: rex.Event
---@field state     string
---@field progress? integer

---@class rex.terminal.PwdChangedEvent: rex.Event
---@field pwd    string
---@field owner? rex.ProcessOwner

---@class rex.terminal.SelectionCopiedEvent: rex.Event
---@field text?  string
---@field id?    integer
---@field bytes? integer

---@class rex.terminal.SizeChangedEvent: rex.Event
---@field columns        integer
---@field rows           integer
---@field cell_width_px  integer
---@field cell_height_px integer
---@field owner          table
---@field principal?     rex.Principal

---@class rex.terminal.TitleChangedEvent: rex.Event
---@field title  string
---@field owner? rex.ProcessOwner

---@class rex.terminal.UrlClickedEvent: rex.Event
---@field url string

---@class rex.Revision
---@field revision integer

---@class rex.BlockInfo
---@field block_id?     string
---@field label         string
---@field creator_name? string
---@field flavor?       string
---@field host_id?      string
---@field placement     string
---@field window_id?    string
---@field owner?        string

---@class rex.SessionView
---@field revision          integer
---@field session_id?       string
---@field label?            string
---@field active_window_id? string
---@field windows?          rex.Window[]

---@class rex.Window
---@field window_id?        string
---@field label?            string
---@field focused_block_id? string
---@field zoomed_block_id?  string
---@field layers?           rex.Layer[]

---@class rex.Layer
---@field layer_id? string
---@field kind      string
---@field bounds    rex.Bounds
---@field state?    string
---@field layout?   rex.ViewNode
---@field blocks?   rex.LayerBlock[]

---@class rex.ViewNode
---@field rect      number[]
---@field block_id? string
---@field split?    rex.ViewSplit

---@class rex.ViewSplit
---@field split_id? string
---@field direction "horizontal" | "vertical"
---@field ratio     number
---@field before    rex.ViewNode
---@field after     rex.ViewNode

---@class rex.LayerBlock
---@field block_id?     string
---@field label?        string
---@field creator_name? string
---@field flavor?       string
---@field host_id?      string
---@field owner?        string

---@class rex.ProcessInfo
---@field pid           integer
---@field user_id       integer
---@field user?         string
---@field name          string
---@field path?         string
---@field invoked_path? string
---@field argv0?        string
---@field script?       string
---@field cwd?          string  Unavailable when the process directory cannot be read.

---@class rex.ProcessOwner
---@field pid  integer
---@field name string

---@class rex.ExitStatus
---@field exit_code integer
---@field error?    string

---@class rex.TerminalOptions
---@field shell?         string                  Use "none" to run command directly.
---@field command?       string[]                Omit to start an interactive shell.
---@field args?          string[]                Deprecated; use command.
---@field login?         boolean
---@field interactive?   boolean
---@field cwd?           string                  Empty or invalid directories fall back to the user home.
---@field path_prepend?  string[]
---@field size?          rex.TerminalSize
---@field theme?         rex.TerminalTheme
---@field initial_input? string                  Sent literally, without an added newline.
---@field exit?          rex.TerminalExitOptions

---@class rex.TerminalSize
---@field columns         integer
---@field rows            integer
---@field cell_width_px?  integer
---@field cell_height_px? integer

---@class rex.TerminalTheme
---@field foreground? string
---@field background? string
---@field cursor?     string
---@field palette?    string[]
---@field scheme?     string

---@class rex.TerminalExitOptions
---@field on_completion?           boolean
---@field quick_exit_threshold_ms? integer

---@class rex.ConnectedClient
---@field client_id?          string
---@field principal           rex.Principal
---@field info?               rex.ClientMetadata
---@field connected_at        string
---@field connection_state?   string
---@field connection_lost_at? string

---@class rex.Principal
---@field kind         string
---@field transport    string
---@field display      string
---@field remote_addr? string
---@field uid?         integer
---@field gid?         integer
---@field pid?         integer
---@field sid?         string
---@field user_id?     string
---@field login_name?  string
---@field node?        string
---@field tags?        string[]
---@field path?        string[]

---@class rex.ClientMetadata
---@field kind?     string
---@field platform? string
---@field name?     string
---@field version?  string
---@field label?    string

---@class rex.BlockApi
---@field events?  table
---@field methods? table<string, rex.BlockMethod>

---@class rex.BlockMethod
---@field description?   string
---@field input_schema?  any
---@field output_schema? any
---@field actions?       rex.BlockAction[]

---@class rex.BlockAction
---@field name         string
---@field title        string
---@field description? string
---@field category?    string
---@field keywords?    string
---@field args?        any
---@field repeats?     boolean

---@class rex.ProgramStatus
---@field id?            string
---@field state          string
---@field kind?          string
---@field progress?      integer
---@field app?           string
---@field effective_app? string
---@field title?         string
---@field msg?           string
---@field updated_at     string
---@field owner?         rex.ProcessOwner

---@class rex.DirectoryEntry
---@field name     string
---@field symlink? boolean
---@field file?    boolean

---@class rex.TerminalDesiredSize
---@field client_id? string
---@field columns    integer
---@field rows       integer
---@field updated_at string

---@class rex.session.Args
---@field session_id? string

---@class rex.session.BlockArgs
---@field session_id? string
---@field block_id?   string

---@class rex.session.WindowArgs
---@field session_id? string
---@field window_id?  string

---@class rex.session.LayerArgs
---@field session_id? string
---@field layer_id?   string

---@class rex.session.FocusCycleArgs
---@field session_id? string
---@field wrap?       boolean

---@class rex.session.LayerOrderArgs
---@field session_id?        string
---@field layer_id?          string
---@field relative_layer_id? string

---@class rex.session.ListBlocksResult
---@field blocks? rex.BlockInfo[]

---@class rex.session.ListClientsResult
---@field clients? rex.ConnectedClient[]

---@class rex.session.DescribeBlockResult
---@field block rex.BlockInfo
---@field api?  rex.BlockApi

---@class rex.session.NewWindowArgs
---@field session_id?   string
---@field window_label? string
---@field layout?       rex.Layout
---@field focus?        boolean

---@class rex.session.NewWindowResult
---@field window_id? string
---@field block_ids? string[]
---@field revision   integer

---@class rex.session.NewSplitArgs
---@field session_id? string
---@field anchor_id?  string
---@field window_id?  string
---@field direction   "horizontal" | "vertical"
---@field side        "before" | "after"
---@field ratio?      number
---@field layout?     rex.Layout
---@field focus?      boolean

---@class rex.session.NewSplitResult
---@field anchor_id? string
---@field block_ids? string[]
---@field split_ids? string[]
---@field revision   integer

---@class rex.session.NewBlockArgs
---@field session_id? string
---@field flavor      string
---@field options?    any
---@field label?      string

---@class rex.session.NewBlockResult
---@field block_id? string
---@field revision  integer

---@class rex.session.NewLayerArgs
---@field session_id? string
---@field window_id?  string
---@field bounds      rex.Bounds
---@field layout?     rex.Layout
---@field focus?      boolean

---@class rex.session.NewLayerResult
---@field layer_id?  string
---@field block_ids? string[]
---@field revision   integer

---@class rex.session.CloseWindowArgs
---@field session_id? string
---@field window_id?  string

---@class rex.session.MoveBlockArgs
---@field session_id?      string
---@field block_id?        string
---@field anchor_block_id? string
---@field direction?       "horizontal" | "vertical"
---@field side?            "before" | "after"
---@field ratio?           number

---@class rex.session.MoveBlockResult
---@field created_split_id? string
---@field removed_split_id? string
---@field revision          integer

---@class rex.session.SwapBlocksArgs
---@field session_id?     string
---@field block_id?       string
---@field other_block_id? string

---@class rex.session.FloatBlockArgs
---@field session_id? string
---@field block_id?   string
---@field bounds      rex.Bounds

---@class rex.session.FloatBlockResult
---@field layer_id? string
---@field revision  integer

---@class rex.session.ZoomBlockArgs
---@field session_id? string
---@field block_id?   string
---@field window_id?  string
---@field zoom?       boolean

---@class rex.session.ZoomBlockResult
---@field block_id? string
---@field zoomed    boolean
---@field revision  integer

---@class rex.session.ResizePaneArgs
---@field session_id?      string
---@field direction        "horizontal" | "vertical"
---@field before_block_id? string
---@field after_block_id?  string
---@field ratio            number

---@class rex.session.ResizeLayerArgs
---@field session_id? string
---@field layer_id?   string
---@field bounds      rex.Bounds

---@class rex.session.MoveWindowArgs
---@field session_id?       string
---@field window_id?        string
---@field before_window_id? string

---@class rex.session.FocusDirectionArgs
---@field session_id? string
---@field direction   "left" | "right" | "up" | "down"
---@field wrap?       boolean

---@class rex.session.SetLabelArgs
---@field session_id? string
---@field label?      string

---@class rex.session.SetWindowLabelArgs
---@field session_id? string
---@field window_id?  string
---@field label?      string

---@class rex.session.SetBlockLabelArgs
---@field session_id? string
---@field block_id?   string
---@field label?      string

---@class rex.session.AttachResult
---@field client_id string
---@field view      rex.SessionView

---@class rex.terminal.FormatCall
---@field session_id? string
---@field block_id?   string
---@field args?       rex.terminal.FormatCallArgs

---@class rex.terminal.FormatResult
---@field content string
---@field id?     integer
---@field total?  integer
---@field eof?    boolean

---@class rex.terminal.CallArgs
---@field session_id? string
---@field block_id?   string

---@class rex.terminal.ProcessResult
---@field last_exit?  rex.ExitStatus    Absent while the terminal program is still running.
---@field child?      rex.ProcessInfo
---@field foreground? rex.ProcessInfo   Absent when the foreground process cannot be inspected.
---@field ancestors?  rex.ProcessInfo[]
---@field home?       string

---@class rex.terminal.PwdResult
---@field pwd?   string           A file:// URL for OSC 7, or a plain path otherwise.
---@field owner? rex.ProcessOwner

---@class rex.terminal.TitleResult
---@field title  string
---@field owner? rex.ProcessOwner

---@class rex.terminal.SizeResult
---@field columns        integer
---@field rows           integer
---@field cell_width_px  integer
---@field cell_height_px integer
---@field owner?         string
---@field desired        rex.TerminalDesiredSize[]

---@class rex.terminal.WriteCall
---@field session_id? string
---@field block_id?   string
---@field args        rex.terminal.WriteCallArgs

---@class rex.terminal.WriteResult
---@field bytes_written integer

---@class rex.terminal.ResizeCall
---@field session_id? string
---@field block_id?   string
---@field args        rex.TerminalSize

---@class rex.terminal.SetThemeCall
---@field session_id? string
---@field block_id?   string
---@field args?       rex.TerminalTheme

---@class rex.terminal.ProgramStatusResult
---@field records rex.ProgramStatus[]

---@class rex.terminal.ListDirCall
---@field session_id? string
---@field block_id?   string
---@field args?       rex.terminal.ListDirCallArgs

---@class rex.terminal.ListDirResult
---@field path      string
---@field home      string
---@field status    string
---@field entries?  rex.DirectoryEntry[]
---@field truncated boolean

---@class rex.terminal.FormatCallArgs
---@field format?                 string
---@field trim?                   boolean
---@field unwrap?                 boolean
---@field extra_charsets?         boolean
---@field extra_cursor?           boolean
---@field extra_hyperlink?        boolean
---@field extra_keyboard?         boolean
---@field extra_kitty_keyboard?   boolean
---@field extra_modes?            boolean
---@field extra_palette?          boolean
---@field extra_protection?       boolean
---@field extra_pwd?              boolean
---@field extra_scrolling_region? boolean
---@field extra_style?            boolean
---@field extra_tabstops?         boolean
---@field max_bytes?              integer

---@class rex.terminal.WriteCallArgs
---@field data string

---@class rex.terminal.ListDirCallArgs
---@field path?   string
---@field prefix? string
---@field limit?  integer
---@field files?  boolean

---@type rex
rex = {}
