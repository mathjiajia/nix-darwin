{
  programs.nixvim.highlight = {
    FoldColumn = {fg = "#595959";};
    SignColumn = {fg = "#404040";};
    SignColumnSB = {
      fg = "#404040";
      bg = "#141617";
    };
    Substitute = {
      fg = "#d3869b";
      bg = "#404040";
    };
    LineNr = {fg = "#404040";};
    CursorLineNr = {fg = "#7daea3";};
    MatchParen = {
      bg = "#404040";
      bold = true;
      fg = "#e78a4e";
    };
    ModeMsg = {
      bold = true;
      fg = "#ebdbb2";
    };
    MsgSeparator = {};
    MoreMsg = {fg = "#83a598";};
    NonText = {fg = "#595959";};
    Normal = {
      bg = "#1d2021";
      fg = "#ebdbb2";
    };
    NormalNC = {
      bg = "#1d2021";
      fg = "#ebdbb2";
    };
    NvimSurroundHighlight = {
      sp = "#e78a4e";
      underline = true;
    };
    NormalSB = {
      bg = "#141617";
      fg = "#ebdbb2";
    };
    NormalFloat = {
      bg = "#191b1c";
      fg = "#ebdbb2";
    };
    OverseerRUNNING = {fg = "#d8a657";};
    FloatBorder = {fg = "#83a598";};
    FloatTitle = {fg = "#bdae93";};
    Pmenu = {
      fg = "#a89984";
      bg = "#252525";
    };
    OverseerTask = {fg = "#83a598";};
    PmenuSel = {
      bold = true;
      bg = "#404040";
    };
    PmenuSbar = {bg = "#404040";};
    PmenuThumb = {bg = "#595959";};
    Question = {fg = "#83a598";};
    QuickFixLine = {
      bold = true;
      bg = "#404040";
    };
    Search = {
      fg = "#ebdbb2";
      bg = "#425243";
    };
    IncSearch = {
      fg = "#191b1c";
      bg = "#8DB687";
    };
    CurSearch = {
      fg = "#191b1c";
      bg = "#ea6962";
    };
    SpecialKey = {link = "NonText";};
    SpellBad = {
      sp = "#ea6962";
      undercurl = true;
    };
    SpellCap = {
      sp = "#d8a657";
      undercurl = true;
    };
    SpellLocal = {
      sp = "#83a598";
      undercurl = true;
    };
    SpellRare = {
      sp = "#a9b665";
      undercurl = true;
    };
    StatusLine = {
      bg = "#191b1c";
      fg = "#ebdbb2";
    };
    StatusLineNC = {
      bg = "#191b1c";
      fg = "#404040";
    };
    TabLine = {
      fg = "#595959";
      bg = "#141617";
    };
    BlinkCmpSignatureHelpActiveParameter = {fg = "#e396a4";};
    BlinkCmpSignatureHelpBorder = {fg = "#83a598";};
    TermCursor = {
      bg = "#eb7a73";
      fg = "#1d2021";
    };
    BlinkCmpKindText = {fg = "#a9b665";};
    BlinkCmpKindMethod = {fg = "#83a598";};
    BlinkCmpKindFunction = {fg = "#83a598";};
    BlinkCmpKindConstructor = {fg = "#83a598";};
    BlinkCmpKindField = {fg = "#a9b665";};
    BlinkCmpKindVariable = {fg = "#eb7a73";};
    WinBar = {fg = "#eb7a73";};
    WinBarNC = {link = "WinBar";};
    BlinkCmpKindModule = {fg = "#83a598";};
    BlinkCmpKindProperty = {fg = "#83a598";};
    SpecialComment = {link = "Special";};
    BlinkCmpKindValue = {fg = "#e78a4e";};
    BlinkCmpKindEnum = {fg = "#d8a657";};
    BlinkCmpKindKeyword = {fg = "#e396a4";};
    BlinkCmpKindSnippet = {fg = "#eb7a73";};
    BlinkCmpKindColor = {fg = "#ea6962";};
    BlinkCmpKindFile = {fg = "#83a598";};
    BlinkCmpKindReference = {fg = "#ea6962";};
    BlinkCmpKindFolder = {fg = "#83a598";};
    Function = {fg = "#83a598";};
    Statement = {fg = "#e396a4";};
    Conditional = {
      italic = true;
      fg = "#e396a4";
    };
    Repeat = {fg = "#e396a4";};
    Label = {fg = "#89b482";};
    Operator = {fg = "#99c792";};
    Keyword = {fg = "#e396a4";};
    Exception = {fg = "#e396a4";};
    PreProc = {fg = "#d3869b";};
    Include = {fg = "#e396a4";};
    Define = {link = "PreProc";};
    Macro = {fg = "#e396a4";};
    PreCondit = {link = "PreProc";};
    StorageClass = {fg = "#d8a657";};
    Structure = {fg = "#d8a657";};
    Type = {fg = "#d8a657";};
    Typedef = {link = "Type";};
    SpecialChar = {link = "Special";};
    Tag = {
      bold = true;
      fg = "#7daea3";
    };
    Delimiter = {fg = "#a89984";};
    Debug = {link = "Special";};
    Underlined = {underline = true;};
    Bold = {bold = true;};
    Italic = {italic = true;};
    Error = {fg = "#ea6962";};
    Todo = {
      bg = "#eb7a73";
      bold = true;
      fg = "#1d2021";
    };
    qfLineNr = {fg = "#d8a657";};
    qfFileName = {fg = "#83a598";};
    htmlH1 = {
      bold = true;
      fg = "#d3869b";
    };
    htmlH2 = {
      bold = true;
      fg = "#83a598";
    };
    mkdCodeDelimiter = {
      fg = "#ebdbb2";
      bg = "#1d2021";
    };
    mkdCodeStart = {
      bold = true;
      fg = "#eb7a73";
    };
    mkdCodeEnd = {
      bold = true;
      fg = "#eb7a73";
    };
    debugPC = {bg = "#141617";};
    debugBreakpoint = {
      fg = "#595959";
      bg = "#1d2021";
    };
    illuminatedWord = {bg = "#404040";};
    illuminatedCurWord = {bg = "#404040";};
    diffAdded = {fg = "#a9b665";};
    diffRemoved = {fg = "#ea6962";};
    diffChanged = {fg = "#83a598";};
    diffOldFile = {fg = "#d8a657";};
    diffNewFile = {fg = "#e78a4e";};
    diffFile = {fg = "#83a598";};
    diffLine = {fg = "#595959";};
    diffIndexLine = {fg = "#8ec07c";};
    DiffAdd = {bg = "#363B2D";};
    DiffChange = {bg = "#242929";};
    DiffDelete = {bg = "#422D2D";};
    DiffText = {bg = "#3C4845";};
    healthError = {fg = "#ea6962";};
    healthSuccess = {fg = "#8ec07c";};
    healthWarning = {fg = "#d8a657";};
    LspReferenceText = {bg = "#404040";};
    LspReferenceRead = {bg = "#404040";};
    LspReferenceWrite = {bg = "#404040";};
    DiagnosticVirtualTextError = {
      bg = "#302727";
      italic = true;
      fg = "#ea6962";
    };
    DiagnosticVirtualTextWarn = {
      bg = "#2F2D26";
      italic = true;
      fg = "#d8a657";
    };
    DiagnosticVirtualTextInfo = {
      bg = "#29302C";
      italic = true;
      fg = "#99c792";
    };
    DiagnosticVirtualTextHint = {
      bg = "#282F2A";
      italic = true;
      fg = "#8ec07c";
    };
    DiagnosticVirtualTextOk = {
      bg = "#282F2A";
      italic = true;
      fg = "#a9b665";
    };
    DiagnosticError = {
      bg = "NONE";
      italic = true;
      fg = "#ea6962";
    };
    DiagnosticWarn = {
      bg = "NONE";
      italic = true;
      fg = "#d8a657";
    };
    DiagnosticInfo = {
      bg = "NONE";
      italic = true;
      fg = "#99c792";
    };
    DiagnosticHint = {
      bg = "NONE";
      italic = true;
      fg = "#8ec07c";
    };
    DiagnosticOk = {
      bg = "NONE";
      italic = true;
      fg = "#a9b665";
    };
    DiagnosticUnderlineError = {
      sp = "#ea6962";
      underline = true;
    };
    DiagnosticUnderlineWarn = {
      sp = "#d8a657";
      underline = true;
    };
    DiagnosticUnderlineInfo = {
      sp = "#99c792";
      underline = true;
    };
    DiagnosticUnderlineHint = {
      sp = "#8ec07c";
      underline = true;
    };
    DiagnosticUnderlineOk = {
      sp = "#a9b665";
      underline = true;
    };
    DiagnosticFloatingError = {fg = "#ea6962";};
    DiagnosticFloatingWarn = {fg = "#d8a657";};
    DiagnosticFloatingInfo = {fg = "#99c792";};
    DiagnosticFloatingHint = {fg = "#8ec07c";};
    DiagnosticFloatingOk = {fg = "#a9b665";};
    DiagnosticSignError = {fg = "#ea6962";};
    DiagnosticSignWarn = {fg = "#d8a657";};
    DiagnosticSignInfo = {fg = "#99c792";};
    DiagnosticSignHint = {fg = "#8ec07c";};
    DiagnosticSignOk = {fg = "#a9b665";};
    LspDiagnosticsDefaultError = {fg = "#ea6962";};
    LspDiagnosticsDefaultWarning = {fg = "#d8a657";};
    LspDiagnosticsDefaultInformation = {fg = "#99c792";};
    LspDiagnosticsDefaultHint = {fg = "#8ec07c";};
    LspSignatureActiveParameter = {
      bold = true;
      bg = "#292929";
    };
    LspDiagnosticsError = {fg = "#ea6962";};
    LspDiagnosticsWarning = {fg = "#d8a657";};
    LspDiagnosticsInformation = {fg = "#99c792";};
    LspDiagnosticsHint = {fg = "#8ec07c";};
    LspDiagnosticsVirtualTextError = {
      italic = true;
      fg = "#ea6962";
    };
    LspDiagnosticsVirtualTextWarning = {
      italic = true;
      fg = "#d8a657";
    };
    LspDiagnosticsVirtualTextInformation = {
      italic = true;
      fg = "#99c792";
    };
    LspDiagnosticsVirtualTextHint = {
      italic = true;
      fg = "#8ec07c";
    };
    LspDiagnosticsUnderlineError = {
      sp = "#ea6962";
      underline = true;
    };
    LspDiagnosticsUnderlineWarning = {
      sp = "#d8a657";
      underline = true;
    };
    LspDiagnosticsUnderlineInformation = {
      sp = "#99c792";
      underline = true;
    };
    LspDiagnosticsUnderlineHint = {
      sp = "#8ec07c";
      underline = true;
    };
    LspCodeLens = {fg = "#595959";};
    LspCodeLensSeparator = {link = "LspCodeLens";};
    LspInlayHint = {
      bg = "#252626";
      fg = "#595959";
    };
    LspInfoBorder = {link = "FloatBorder";};
    "@lsp.type.boolean" = {link = "@boolean";};
    "@boolean" = {link = "Boolean";};
    "@lsp.type.builtinType" = {link = "@type.builtin";};
    "@type.builtin" = {fg = "#d8a657";};
    "@lsp.type.comment" = {link = "@comment";};
    "@comment" = {link = "Comment";};
    "@lsp.type.enum" = {link = "@type";};
    "@type" = {link = "Type";};
    "@lsp.type.enumMember" = {link = "@constant";};
    "@constant" = {link = "Constant";};
    "@lsp.type.escapeSequence" = {link = "@string.escape";};
    "@string.escape" = {fg = "#d3869b";};
    "@lsp.type.formatSpecifier" = {link = "@punctuation.special";};
    "@punctuation.special" = {link = "Special";};
    "@lsp.type.interface" = {fg = "#eb7a73";};
    "@lsp.type.keyword" = {link = "@keyword";};
    "@keyword" = {link = "Keyword";};
    "@lsp.type.namespace" = {link = "@module";};
    "@module" = {
      italic = true;
      fg = "#7daea3";
    };
    "@lsp.type.number" = {link = "@number";};
    "@number" = {link = "Number";};
    "@lsp.type.operator" = {link = "@operator";};
    "@operator" = {link = "Operator";};
    "@lsp.type.parameter" = {link = "@parameter";};
    "@lsp.type.property" = {link = "@property";};
    "@property" = {fg = "#7daea3";};
    "@lsp.type.selfKeyword" = {link = "@variable.builtin";};
    "@variable.builtin" = {fg = "#ea6962";};
    "@lsp.type.typeAlias" = {link = "@type.definition";};
    "@type.definition" = {link = "Type";};
    "@lsp.type.unresolvedReference" = {link = "@error";};
    "@error" = {link = "Error";};
    WarningMsg = {fg = "#d8a657";};
    "@lsp.typemod.class.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.enum.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.enumMember.defaultLibrary" = {link = "@constant.builtin";};
    "@constant.builtin" = {fg = "#e78a4e";};
    "@lsp.typemod.function.defaultLibrary" = {link = "@function.builtin";};
    "@function.builtin" = {fg = "#e78a4e";};
    "@lsp.typemod.keyword.async" = {link = "@keyword.coroutine";};
    "@keyword.coroutine" = {link = "Keyword";};
    "@lsp.typemod.macro.defaultLibrary" = {link = "@function.builtin";};
    "@lsp.typemod.method.defaultLibrary" = {link = "@function.builtin";};
    "@lsp.typemod.operator.injected" = {link = "@operator";};
    "@lsp.typemod.string.injected" = {link = "@string";};
    "@string" = {link = "String";};
    "@lsp.typemod.type.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.variable.defaultLibrary" = {link = "@variable.builtin";};
    "@lsp.typemod.variable.injected" = {link = "@variable";};
    "@variable" = {fg = "#ebdbb2";};
    AerialLine = {
      bg = "NONE";
      fg = "#d8a657";
    };
    AerialGuide = {fg = "#a89984";};
    AerialBooleanIcon = {link = "@boolean";};
    AerialClassIcon = {link = "@type";};
    AerialConstantIcon = {link = "@constant";};
    AerialConstructorIcon = {link = "@constructor";};
    "@constructor" = {fg = "#89b482";};
    AerialFieldIcon = {link = "@field";};
    AerialFunctionIcon = {link = "@function";};
    "@function" = {link = "Function";};
    AerialMethodIcon = {link = "@method";};
    AerialNamespaceIcon = {link = "@namespace";};
    AerialNumberIcon = {link = "@number";};
    AerialOperatorIcon = {link = "@operator";};
    AerialTypeParameterIcon = {link = "@type";};
    AerialPropertyIcon = {link = "@property";};
    AerialStringIcon = {link = "@string";};
    AerialVariableIcon = {link = "@constant";};
    AerialEnumMemberIcon = {link = "@field";};
    AerialEnumIcon = {link = "@type";};
    AerialFileIcon = {link = "@text.uri";};
    AerialModuleIcon = {link = "@namespace";};
    AerialPackageIcon = {link = "@namespace";};
    AerialInterfaceIcon = {link = "@type";};
    AerialStructIcon = {link = "@type";};
    AerialEventIcon = {link = "@type";};
    AerialArrayIcon = {link = "@constant";};
    AerialObjectIcon = {link = "@type";};
    AerialKeyIcon = {link = "@type";};
    AerialNullIcon = {link = "@type";};
    BlinkCmpLabel = {fg = "#a89984";};
    BlinkCmpLabelDeprecated = {
      strikethrough = true;
      fg = "#595959";
    };
    BlinkCmpKind = {fg = "#83a598";};
    BlinkCmpMenu = {fg = "#ebdbb2";};
    BlinkCmpMenuBorder = {fg = "#83a598";};
    BlinkCmpDocBorder = {fg = "#83a598";};
    "@string.special.path.gitignore" = {fg = "#ebdbb2";};
    "@comment.warning.gitcommit" = {fg = "#d8a657";};
    "@type.builtin.cpp" = {fg = "#d8a657";};
    "@property.cpp" = {fg = "#ebdbb2";};
    "@type.builtin.c" = {fg = "#d8a657";};
    "@variable.member.yaml" = {fg = "#83a598";};
    "@constructor.lua" = {fg = "#eb7a73";};
    "@label.json" = {fg = "#83a598";};
    "@property.toml" = {fg = "#83a598";};
    "@markup.heading.6.markdown" = {link = "rainbow6";};
    "@markup.heading.5.markdown" = {link = "rainbow5";};
    "@markup.heading.4.markdown" = {link = "rainbow4";};
    "@markup.heading.3.markdown" = {link = "rainbow3";};
    "@markup.heading.2.markdown" = {link = "rainbow2";};
    OverseerField = {fg = "#a9b665";};
    OverseerComponent = {fg = "#d8a657";};
    OverseerOutput = {fg = "#ebdbb2";};
    OverseerTaskBorder = {fg = "#99c792";};
    OverseerFAILURE = {fg = "#ea6962";};
    OverseerSUCCESS = {fg = "#a9b665";};
    OverseerPENDING = {};
    NoiceMini = {
      blend = 0;
      fg = "#ebdbb2";
    };
    NoiceConfirmBorder = {fg = "#83a598";};
    NoiceCmdlinePopupBorderSearch = {fg = "#d8a657";};
    NoiceCmdlinePopupBorder = {fg = "#7daea3";};
    NoiceCmdlineIconSearch = {fg = "#d8a657";};
    NoiceCmdlineIcon = {
      italic = true;
      fg = "#99c792";
    };
    NoiceCmdline = {fg = "#ebdbb2";};
    MiniIconsYellow = {fg = "#d8a657";};
    MiniIconsRed = {fg = "#ea6962";};
    MiniIconsPurple = {fg = "#e396a4";};
    MiniIconsOrange = {fg = "#e78a4e";};
    MiniIconsGrey = {fg = "#ebdbb2";};
    MiniIconsGreen = {fg = "#a9b665";};
    MiniIconsCyan = {fg = "#8ec07c";};
    ColorColumn = {bg = "#292929";};
    Conceal = {fg = "#928374";};
    Cursor = {
      bg = "#ebdbb2";
      fg = "#1d2021";
    };
    lCursor = {
      bg = "#ebdbb2";
      fg = "#1d2021";
    };
    CursorIM = {
      bg = "#ebdbb2";
      fg = "#1d2021";
    };
    CursorColumn = {bg = "#191b1c";};
    CursorLine = {bg = "#252626";};
    Directory = {fg = "#83a598";};
    EndOfBuffer = {fg = "#1d2021";};
    ErrorMsg = {
      bold = true;
      italic = true;
      fg = "#ea6962";
    };
    MiniIconsBlue = {fg = "#83a598";};
    MiniIconsAzure = {fg = "#89b482";};
    VertSplit = {fg = "#141617";};
    Folded = {
      bg = "#404040";
      fg = "#83a598";
    };
    MiniHipatternsTodo = {
      bg = "#8ec07c";
      bold = true;
      fg = "#1d2021";
    };
    MiniHipatternsNote = {
      bg = "#99c792";
      bold = true;
      fg = "#1d2021";
    };
    MiniHipatternsHack = {
      bg = "#d8a657";
      bold = true;
      fg = "#1d2021";
    };
    MiniHipatternsFixme = {
      bg = "#ea6962";
      bold = true;
      fg = "#1d2021";
    };
    GrugFarResultsMatch = {link = "IncSearch";};
    FlashPrompt = {link = "NormalFloat";};
    "@keyword.conditional" = {link = "Conditional";};
    "@keyword.conditional.ternary" = {link = "Operator";};
    "@keyword.directive" = {link = "PreProc";};
    "@keyword.directive.define" = {link = "Define";};
    "@keyword.export" = {fg = "#99c792";};
    "@punctuation.delimiter" = {link = "Delimiter";};
    "@punctuation.bracket" = {fg = "#a89984";};
    "@comment.documentation" = {link = "Comment";};
    "@comment.error" = {
      bg = "#ea6962";
      fg = "#1d2021";
    };
    "@comment.warning" = {
      bg = "#d8a657";
      fg = "#1d2021";
    };
    "@comment.hint" = {
      bg = "#83a598";
      fg = "#1d2021";
    };
    "@comment.todo" = {
      bg = "#eb7a73";
      fg = "#1d2021";
    };
    "@comment.note" = {
      bg = "#eb7a73";
      fg = "#1d2021";
    };
    "@markup" = {fg = "#ebdbb2";};
    "@markup.strong" = {
      bold = true;
      fg = "#ea6962";
    };
    "@markup.italic" = {
      italic = true;
      fg = "#ea6962";
    };
    "@markup.strikethrough" = {
      strikethrough = true;
      fg = "#ebdbb2";
    };
    "@markup.underline" = {link = "Underlined";};
    "@markup.heading" = {
      bold = true;
      fg = "#83a598";
    };
    "@markup.math" = {fg = "#83a598";};
    "@markup.quote" = {
      bold = true;
      fg = "#ea6962";
    };
    "@markup.environment" = {fg = "#d3869b";};
    "@markup.environment.name" = {fg = "#83a598";};
    "@markup.link" = {link = "Tag";};
    "@markup.link.label" = {link = "Label";};
    "@markup.link.url" = {
      italic = true;
      underline = true;
      fg = "#eb7a73";
    };
    "@markup.raw" = {fg = "#8ec07c";};
    "@markup.list" = {link = "Special";};
    "@markup.list.checked" = {fg = "#a9b665";};
    "@markup.list.unchecked" = {fg = "#928374";};
    "@diff.plus" = {link = "diffAdded";};
    "@diff.minus" = {link = "diffRemoved";};
    "@diff.delta" = {link = "diffChanged";};
    "@tag" = {fg = "#e396a4";};
    "@tag.attribute" = {
      italic = true;
      fg = "#8ec07c";
    };
    "@tag.delimiter" = {fg = "#99c792";};
    "@function.builtin.bash" = {
      italic = true;
      fg = "#ea6962";
    };
    "@markup.heading.1.markdown" = {link = "rainbow1";};
    RainbowDelimiterRed = {fg = "#ea6962";};
    RainbowDelimiterYellow = {fg = "#d8a657";};
    RainbowDelimiterBlue = {fg = "#83a598";};
    RainbowDelimiterOrange = {fg = "#e78a4e";};
    RainbowDelimiterGreen = {fg = "#a9b665";};
    RainbowDelimiterViolet = {fg = "#e396a4";};
    RainbowDelimiterCyan = {fg = "#8ec07c";};
    SnacksNormal = {link = "NormalFloat";};
    SnacksWinBar = {link = "Title";};
    SnacksBackdrop = {fg = "#595959";};
    SnacksNormalNC = {link = "NormalFloat";};
    SnacksWinBarNC = {link = "SnacksWinBar";};
    SnacksNotifierInfo = {fg = "#83a598";};
    SnacksNotifierIconInfo = {fg = "#83a598";};
    SnacksNotifierTitleInfo = {
      italic = true;
      fg = "#83a598";
    };
    SnacksNotifierFooterInfo = {link = "DiagnosticInfo";};
    SnacksNotifierBorderInfo = {fg = "#83a598";};
    SnacksNotifierWarn = {fg = "#d8a657";};
    SnacksNotifierIconWarn = {fg = "#d8a657";};
    SnacksNotifierTitleWarn = {
      italic = true;
      fg = "#d8a657";
    };
    SnacksNotifierBorderWarn = {fg = "#d8a657";};
    SnacksNotifierFooterWarn = {link = "DiagnosticWarn";};
    SnacksNotifierDebug = {fg = "#e78a4e";};
    SnacksNotifierIconDebug = {fg = "#e78a4e";};
    SnacksNotifierTitleDebug = {
      italic = true;
      fg = "#e78a4e";
    };
    SnacksNotifierBorderDebug = {fg = "#e78a4e";};
    SnacksNotifierFooterDebug = {link = "DiagnosticHint";};
    SnacksNotifierError = {fg = "#ea6962";};
    SnacksNotifierIconError = {fg = "#ea6962";};
    SnacksNotifierTitleError = {
      italic = true;
      fg = "#ea6962";
    };
    SnacksNotifierBorderError = {fg = "#ea6962";};
    SnacksNotifierFooterError = {link = "DiagnosticError";};
    SnacksNotifierTrace = {fg = "#eb7a73";};
    SnacksNotifierIconTrace = {fg = "#eb7a73";};
    SnacksNotifierTitleTrace = {
      italic = true;
      fg = "#eb7a73";
    };
    SnacksNotifierBorderTrace = {fg = "#eb7a73";};
    SnacksNotifierFooterTrace = {link = "DiagnosticHint";};
    SnacksDashboardNormal = {link = "Normal";};
    SnacksDashboardDesc = {fg = "#83a598";};
    SnacksDashboardFile = {fg = "#7daea3";};
    SnacksDashboardDir = {link = "NonText";};
    SnacksDashboardFooter = {
      italic = true;
      fg = "#d8a657";
    };
    SnacksDashboardHeader = {fg = "#83a598";};
    SnacksDashboardIcon = {
      bold = true;
      fg = "#d3869b";
    };
    SnacksDashboardKey = {fg = "#e78a4e";};
    SnacksDashboardTerminal = {link = "SnacksDashboardNormal";};
    SnacksDashboardSpecial = {link = "Special";};
    SnacksDashboardTitle = {link = "Title";};
    "@variable.parameter" = {fg = "#ea6962";};
    "@variable.member" = {fg = "#7daea3";};
    "@constant.macro" = {link = "Macro";};
    OverseerCANCELED = {fg = "#a89984";};
    "@label" = {link = "Label";};
    "@string.documentation" = {fg = "#8ec07c";};
    "@string.regexp" = {fg = "#e78a4e";};
    "@string.special" = {link = "Special";};
    "@string.special.path" = {link = "Special";};
    "@string.special.symbol" = {fg = "#eb7a73";};
    "@string.special.url" = {
      italic = true;
      underline = true;
      fg = "#eb7a73";
    };
    "@character" = {link = "Character";};
    "@character.special" = {link = "SpecialChar";};
    "@number.float" = {link = "Float";};
    "@attribute" = {link = "Constant";};
    "@function.call" = {link = "Function";};
    "@function.macro" = {fg = "#8ec07c";};
    "@function.method" = {link = "Function";};
    "@function.method.call" = {link = "Function";};
    "@keyword.modifier" = {link = "Keyword";};
    "@keyword.type" = {link = "Keyword";};
    "@keyword.function" = {fg = "#e396a4";};
    "@keyword.operator" = {link = "Operator";};
    "@keyword.import" = {link = "Include";};
    "@keyword.repeat" = {link = "Repeat";};
    "@keyword.return" = {fg = "#e396a4";};
    "@keyword.debug" = {link = "Exception";};
    "@keyword.exception" = {link = "Exception";};
    FlashCurrent = {
      bg = "#7daea3";
      fg = "#e78a4e";
    };
    FlashMatch = {
      bg = "#7daea3";
      fg = "#7daea3";
    };
    FlashLabel = {
      bg = "#7daea3";
      bold = true;
      fg = "#a9b665";
    };
    FlashBackdrop = {fg = "#595959";};
    DropBarIconUISeparator = {fg = "#928374";};
    DropBarMenuHoverSymbol = {bold = true;};
    DropBarMenuHoverIcon = {reverse = true;};
    DropBarMenuHoverEntry = {link = "Visual";};
    DapUIWinSelect = {fg = "#e78a4e";};
    DapUIUnavailableNC = {link = "DapUIUnavailable";};
    DapUIUnavailable = {fg = "#404040";};
    DapUIRestartNC = {link = "DapUIRestart";};
    DapUIRestart = {fg = "#a9b665";};
    DapUIPlayPauseNC = {link = "DapUIPlayPause";};
    DapUIPlayPause = {fg = "#a9b665";};
    DapUIStopNC = {link = "DapUIStop";};
    DapUIStop = {fg = "#ea6962";};
    DapUIStepOutNC = {link = "DapUIStepOut";};
    DapUIStepOut = {fg = "#83a598";};
    DapUIStepBackNC = {link = "DapUIStepBack";};
    DapUIStepBack = {fg = "#83a598";};
    DapUIStepIntoNC = {link = "DapUIStepInto";};
    DapUIStepInto = {fg = "#83a598";};
    DapUIStepOverNC = {link = "DapUIStepOver";};
    DapUIStepOver = {fg = "#83a598";};
    DapUIBreakpointsDisabledLine = {fg = "#4d4d4d";};
    DapUIBreakpointsCurrentLine = {
      bold = true;
      fg = "#a9b665";
    };
    DapUIBreakpointsInfo = {fg = "#a9b665";};
    DapUIBreakpointsPath = {fg = "#99c792";};
    DapUIWatchesError = {fg = "#ea6962";};
    DapUIWatchesValue = {fg = "#a9b665";};
    DapUIWatchesEmpty = {fg = "#ea6962";};
    DapUIFloatBorder = {link = "FloatBorder";};
    DapUILineNumber = {fg = "#99c792";};
    DapUISource = {fg = "#7daea3";};
    DapUIStoppedThread = {fg = "#99c792";};
    DapUIThread = {fg = "#a9b665";};
    DapUIDecoration = {fg = "#99c792";};
    DapUIModifiedValue = {fg = "#e78a4e";};
    DapUIVariable = {fg = "#ebdbb2";};
    DapUIValue = {fg = "#99c792";};
    DapUIType = {fg = "#e396a4";};
    DapUIScope = {fg = "#99c792";};
    DapStopped = {fg = "#ea6962";};
    DapLogPoint = {fg = "#99c792";};
    DapBreakpointRejected = {fg = "#e396a4";};
    DapBreakpointCondition = {fg = "#d8a657";};
    DapBreakpoint = {fg = "#ea6962";};
    BlinkCmpKindTypeParameter = {fg = "#ea6962";};
    BlinkCmpKindOperator = {fg = "#99c792";};
    BlinkCmpKindEvent = {fg = "#83a598";};
    BlinkCmpKindStruct = {fg = "#83a598";};
    BlinkCmpKindConstant = {fg = "#e78a4e";};
    BlinkCmpKindEnumMember = {fg = "#8ec07c";};
    "@lsp.type.variable" = {};
    Comment = {
      italic = true;
      fg = "#a89984";
    };
    WinSeparator = {fg = "#141617";};
    WildMenu = {bg = "#595959";};
    Whitespace = {fg = "#404040";};
    VisualNOS = {
      bold = true;
      bg = "#404040";
    };
    Visual = {
      bold = true;
      bg = "#404040";
    };
    Title = {
      bold = true;
      fg = "#83a598";
    };
    TermCursorNC = {
      bg = "#a89984";
      fg = "#1d2021";
    };
    TabLineSel = {link = "Normal";};
    TabLineFill = {bg = "#191b1c";};
    BlinkCmpLabelMatch = {
      bold = true;
      fg = "#ebdbb2";
    };
    BlinkCmpKindClass = {fg = "#d8a657";};
    BlinkCmpKindInterface = {fg = "#d8a657";};
    BlinkCmpKindUnit = {fg = "#a9b665";};
    Identifier = {fg = "#eb7a73";};
    Boolean = {fg = "#e78a4e";};
    Float = {link = "Number";};
    Number = {fg = "#e78a4e";};
    Character = {fg = "#8ec07c";};
    String = {fg = "#a9b665";};
    Constant = {fg = "#e78a4e";};
    Special = {fg = "#d3869b";};
  };
}
