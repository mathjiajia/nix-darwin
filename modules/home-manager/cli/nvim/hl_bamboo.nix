{
  programs.nixvim.highlight = {
    "@module" = {
      fg = "#96c7ef";
      italic = true;
    };
    "@module.builtin" = {link = "@variable.builtin";};
    "@variable.builtin" = {fg = "#e75a7c";};
    "@module.latex" = {
      fg = "#70c2be";
      italic = true;
    };
    "@number" = {link = "Number";};
    "@number.float" = {link = "Float";};
    "@operator" = {link = "Operator";};
    "@property" = {link = "@variable.member";};
    "@variable.member" = {fg = "#70c2be";};
    "@punctuation.bracket" = {link = "Delimiter";};
    "@punctuation.delimiter" = {link = "Delimiter";};
    "@punctuation.special" = {link = "Special";};
    "@punctuation.special.diff" = {link = "Delimiter";};
    "@string" = {link = "String";};
    "@string.documentation" = {fg = "#ABC896";};
    "@string.escape" = {fg = "#f08080";};
    "@string.regexp" = {link = "Constant";};
    "@string.special" = {link = "Special";};
    "@string.special.path" = {
      fg = "#96c7ef";
      underline = true;
    };
    "@string.special.path.diff" = {fg = "#96c7ef";};
    "@string.special.symbol" = {link = "@variable.member";};
    "@string.special.url" = {
      italic = true;
      fg = "#70c2be";
      underline = true;
    };
    "@tag" = {fg = "#aaaaff";};
    "@tag.attribute" = {link = "@variable.member";};
    "@tag.builtin" = {link = "@tag";};
    "@tag.delimiter" = {link = "Delimiter";};
    "@type" = {link = "Type";};
    "@type.builtin" = {link = "Type";};
    "@type.definition" = {link = "Type";};
    "@variable" = {fg = "#f1e9d2";};
    "@variable.parameter" = {
      fg = "#f08080";
      italic = true;
    };
    "@variable.parameter.builtin" = {
      fg = "#e75a7c";
      italic = true;
    };
    "@lsp.mod.readonly" = {link = "@constant";};
    "@lsp.mod.typeHint" = {link = "@type";};
    "@lsp.type.boolean" = {link = "@boolean";};
    "@lsp.type.builtinAttribute" = {link = "@attribute";};
    "@lsp.type.builtinConstant" = {link = "@constant.builtin";};
    "@lsp.type.builtinType" = {link = "@type.builtin";};
    "@lsp.type.class.markdown" = {};
    "@lsp.type.comment" = {};
    "@lsp.type.decorator" = {link = "@attribute";};
    "@lsp.type.derive" = {link = "@constructor";};
    "@lsp.type.deriveHelper" = {link = "@attribute";};
    "@lsp.type.enum" = {link = "@type";};
    "@lsp.type.enumMember" = {link = "@constant";};
    "@lsp.type.escapeSequence" = {link = "@string.escape";};
    "@lsp.type.event" = {link = "Label";};
    "@lsp.type.formatSpecifier" = {link = "@punctuation.special";};
    "@lsp.type.generic" = {};
    "@lsp.type.interface" = {link = "@type";};
    "@lsp.type.keyword" = {link = "@keyword";};
    "@lsp.type.lifetime" = {link = "StorageClass";};
    "@lsp.type.macro" = {link = "Macro";};
    "@lsp.type.magicFunction" = {link = "@function.builtin";};
    "@lsp.type.method" = {link = "@function.method";};
    "@lsp.type.namespace" = {link = "@module";};
    "@lsp.type.number" = {link = "@number";};
    "@lsp.type.operator" = {link = "@operator";};
    "@lsp.type.operator.cpp" = {};
    "@lsp.type.parameter" = {link = "@variable.parameter";};
    "@lsp.type.property" = {link = "@property";};
    CursorIM = {link = "Cursor";};
    CursorColumn = {link = "CursorLine";};
    CursorLine = {bg = "#2f312c";};
    ColorColumn = {bg = "#3B4235";};
    CursorLineNr = {fg = "#f1e9d2";};
    LineNr = {fg = "#5b5e5a";};
    Conceal = {fg = "#838781";};
    DiffAdd = {
      fg = "NONE";
      bg = "#40531b";
    };
    DiffChange = {
      fg = "NONE";
      bg = "#2a3a57";
    };
    DiffDelete = {
      fg = "NONE";
      bg = "#893f45";
    };
    DiffText = {
      fg = "NONE";
      bg = "#3a4a67";
    };
    DiffAdded = {fg = "#8fb573";};
    DiffRemoved = {fg = "#e75a7c";};
    DiffFile = {fg = "#70c2be";};
    DiffIndexLine = {fg = "#5b5e5a";};
    Directory = {fg = "#57a5e5";};
    ErrorMsg = {
      fg = "#e75a7c";
      bold = true;
    };
    MoreMsg = {
      fg = "#57a5e5";
      bold = true;
    };
    CurSearch = {
      fg = "#252623";
      bg = "#ff9966";
    };
    IncSearch = {link = "CurSearch";};
    Search = {
      fg = "#252623";
      bg = "#e2c792";
    };
    Substitute = {
      fg = "#252623";
      bg = "#8fb573";
    };
    MatchParen = {
      bg = "#5b5e5a";
      fg = "#ff9966";
      bold = true;
    };
    ModeMsg = {
      fg = "#94D1CE";
      bold = true;
    };
    NonText = {fg = "#5b5e5a";};
    Whitespace = {link = "NonText";};
    SpecialKey = {link = "NonText";};
    Pmenu = {
      fg = "#f1e9d2";
      bg = "#2f312c";
    };
    PmenuSbar = {
      fg = "NONE";
      bg = "#2f312c";
    };
    PmenuSel = {bg = "#3a3d37";};
    WildMenu = {
      fg = "#252623";
      bg = "#57a5e5";
    };
    PmenuThumb = {
      fg = "NONE";
      bg = "#5b5e5a";
    };
    Question = {fg = "#dbb651";};
    SpellBad = {
      sp = "#e75a7c";
      fg = "NONE";
      undercurl = true;
    };
    SpellCap = {
      sp = "#dbb651";
      fg = "NONE";
      undercurl = true;
    };
    SpellLocal = {
      sp = "#57a5e5";
      fg = "NONE";
      undercurl = true;
    };
    SpellRare = {
      sp = "#aaaaff";
      fg = "NONE";
      undercurl = true;
    };
    StatusLine = {
      fg = "#f1e9d2";
      bg = "#383b35";
    };
    StatusLineNC = {
      fg = "#5b5e5a";
      bg = "#2f312c";
    };
    TabLine = {
      fg = "#f1e9d2";
      bg = "#2f312c";
    };
    TabLineFill = {
      fg = "#5b5e5a";
      bg = "#2f312c";
    };
    TabLineSel = {
      fg = "#252623";
      bg = "#f1e9d2";
    };
    VertSplit = {fg = "#3a3d37";};
    Title = {
      fg = "#70c2be";
      bold = true;
    };
    Visual = {bg = "#3a3d37";};
    VisualNOS = {
      bg = "#383b35";
      fg = "NONE";
      underline = true;
    };
    WinSeparator = {fg = "#3a3d37";};
    WinBar = {fg = "#838781";};
    WinBarNC = {link = "WinBar";};
    QuickFixLine = {
      fg = "#57a5e5";
      underline = true;
    };
    Debug = {fg = "#ff9966";};
    debugPC = {bg = "#1c1e1b";};
    debugBreakpoint = {
      fg = "#252623";
      bg = "#e75a7c";
    };
    ToolbarButton = {
      fg = "#252623";
      bg = "#68aee8";
    };
    String = {fg = "#8fb573";};
    Constant = {fg = "#ff9966";};
    Character = {link = "Constant";};
    Number = {link = "Constant";};
    Float = {link = "Constant";};
    Boolean = {link = "Constant";};
    Type = {fg = "#dbb651";};
    Typedef = {link = "Type";};
    Structure = {link = "Type";};
    StorageClass = {
      fg = "#dbb651";
      italic = true;
    };
    Identifier = {fg = "#e75a7c";};
    PreProc = {fg = "#aaaaff";};
    PreCondit = {link = "PreProc";};
    Include = {link = "PreProc";};
    Define = {link = "PreProc";};
    Keyword = {fg = "#aaaaff";};
    Exception = {link = "Keyword";};
    Conditional = {
      fg = "#aaaaff";
      italic = true;
    };
    AerialReferenceIcon = {fg = "#ff9966";};
    AerialSnippetIcon = {fg = "#df73ff";};
    AerialStructIcon = {fg = "#dbb651";};
    AerialTextIcon = {fg = "#838781";};
    AerialTypeParameterIcon = {fg = "#f08080";};
    AerialUnitIcon = {fg = "#dbb651";};
    AerialValueIcon = {fg = "#ff9966";};
    AerialVariableIcon = {fg = "#e75a7c";};
    AerialFunctionIcon = {fg = "#57a5e5";};
    AerialOperatorIcon = {fg = "#C5C2EE";};
    AerialKeywordIcon = {fg = "#aaaaff";};
    AerialArrayIcon = {fg = "#dbb651";};
    AerialColorIcon = {fg = "#8fb573";};
    AerialStringIcon = {fg = "#8fb573";};
    AerialConstantIcon = {fg = "#ff9966";};
    AerialDefaultIcon = {fg = "#aaaaff";};
    AerialNumberIcon = {fg = "#ff9966";};
    AerialClassIcon = {fg = "#dbb651";};
    AerialBooleanIcon = {fg = "#ff9966";};
    AerialConstructorIcon = {fg = "#57a5e5";};
    AerialEnumIcon = {fg = "#dbb651";};
    AerialEnumMemberIcon = {fg = "#ff9966";};
    "@lsp.type.selfTypeKeyword" = {link = "@type";};
    "@lsp.type.string" = {link = "";};
    "@lsp.type.typeAlias" = {link = "@type.definition";};
    "@lsp.type.typeParameter" = {link = "@type";};
    "@lsp.type.unresolvedReference" = {
      undercurl = true;
      sp = "#e75a7c";
    };
    "@lsp.type.variable" = {};
    "@lsp.typemod.class.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.enum.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.enumMember.defaultLibrary" = {link = "@constant.builtin";};
    "@lsp.typemod.function.defaultLibrary" = {link = "@function.builtin";};
    "@lsp.typemod.function.builtin" = {link = "@function.builtin";};
    "@lsp.typemod.function.readonly" = {link = "@function.method";};
    "@lsp.typemod.generic.attribute" = {link = "@keyword";};
    "@lsp.typemod.keyword.async" = {link = "@keyword.coroutine";};
    "@lsp.typemod.keyword.injected" = {link = "@keyword";};
    "@lsp.typemod.macro.defaultLibrary" = {link = "@function.builtin";};
    "@lsp.typemod.method.defaultLibrary" = {link = "@function.builtin";};
    "@lsp.typemod.method.readonly" = {link = "@function.method";};
    "@lsp.typemod.operator.injected" = {link = "@operator";};
    "@lsp.typemod.parameter.mutable" = {fg = "#E28899";};
    "@lsp.typemod.parameter.readonly" = {fg = "#F88D73";};
    "@lsp.typemod.property.readonly" = {fg = "#80BC99";};
    "@lsp.typemod.string.injected" = {link = "@string";};
    "@lsp.typemod.struct.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.type.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.typeAlias.defaultLibrary" = {link = "@type.builtin";};
    "@lsp.typemod.variable.callable" = {link = "@function";};
    "@lsp.typemod.variable.defaultLibrary" = {link = "@variable.builtin";};
    "@lsp.typemod.variable.global" = {fg = "#F098AD";};
    "@lsp.typemod.variable.injected" = {link = "@variable";};
    "@lsp.typemod.variable.mutable" = {fg = "#CCD6AE";};
    "@lsp.typemod.variable.static" = {fg = "#96c7ef";};
    DiagnosticDeprecated = {link = "Strike";};
    DiagnosticOk = {fg = "#8fb573";};
    DiagnosticUnnecessary = {link = "Comment";};
    DiagnosticError = {fg = "#e75a7c";};
    DiagnosticHint = {fg = "#aaaaff";};
    DiagnosticInfo = {fg = "#70c2be";};
    WarningMsg = {
      fg = "#dbb651";
      bold = true;
    };
    DiagnosticVirtualTextError = {
      bg = "#382B2C";
      fg = "#e75a7c";
    };
    DiagnosticVirtualTextWarn = {
      bg = "#373428";
      fg = "#dbb651";
    };
    DiagnosticVirtualTextInfo = {
      bg = "#2D3633";
      fg = "#70c2be";
    };
    DiagnosticVirtualTextHint = {
      bg = "#323339";
      fg = "#aaaaff";
    };
    DiagnosticUnderlineError = {
      sp = "#e75a7c";
      undercurl = true;
      underline = false;
    };
    DiagnosticUnderlineHint = {
      sp = "#aaaaff";
      undercurl = true;
      underline = false;
    };
    DiagnosticUnderlineInfo = {
      sp = "#57a5e5";
      undercurl = true;
      underline = false;
    };
    DiagnosticUnderlineWarn = {
      sp = "#dbb651";
      undercurl = true;
      underline = false;
    };
    DiagnosticUnderlineOk = {
      sp = "#8fb573";
      undercurl = true;
      underline = false;
    };
    LspReferenceText = {bg = "#383b35";};
    LspReferenceWrite = {bg = "#383b35";};
    Normal = {
      fg = "#f1e9d2";
      bg = "#252623";
    };
    NormalNC = {
      fg = "#f1e9d2";
      bg = "#252623";
    };
    NormalFloat = {
      fg = "#f1e9d2";
      bg = "#252623";
    };
    FloatBorder = {
      fg = "#aaaaff";
      bg = "#252623";
    };
    FloatTitle = {fg = "#e75a7c";};
    FloatFooter = {fg = "#838781";};
    Terminal = {
      fg = "#f1e9d2";
      bg = "#252623";
    };
    EndOfBuffer = {fg = "#252623";};
    FoldColumn = {fg = "#f1e9d2";};
    Folded = {
      fg = "#f1e9d2";
      bg = "#2f312c";
    };
    SignColumn = {fg = "#f1e9d2";};
    ToolbarLine = {fg = "#f1e9d2";};
    Cursor = {reverse = true;};
    lCursor = {link = "Cursor";};
    BlinkCmpMenuBorder = {link = "FloatBorder";};
    BlinkCmpDocBorder = {link = "FloatBorder";};
    DropBarMenuNormalFloat = {link = "Pmenu";};
    DropBarMenuCurrentContext = {
      fg = "#FFB38C";
      bold = true;
    };
    GitSignsAdd = {fg = "#8fb573";};
    GitSignsAddLn = {fg = "#8fb573";};
    GitSignsAddNr = {fg = "#8fb573";};
    GitSignsChange = {fg = "#57a5e5";};
    GitSignsChangeLn = {fg = "#57a5e5";};
    GitSignsChangeNr = {fg = "#57a5e5";};
    GitSignsDelete = {fg = "#e75a7c";};
    GitSignsDeleteLn = {fg = "#e75a7c";};
    GitSignsDeleteNr = {fg = "#e75a7c";};
    GitSignsUntracked = {fg = "#dbb651";};
    GitSignsUntrackedLn = {fg = "#dbb651";};
    GitSignsUntrackedNr = {fg = "#dbb651";};
    AerialLine = {
      bg = "#383b35";
      fg = "#aaaaff";
      bold = true;
    };
    RainbowDelimiterRed = {fg = "#ED839D";};
    RainbowDelimiterYellow = {fg = "#E4C87D";};
    RainbowDelimiterBlue = {fg = "#81BCEC";};
    RainbowDelimiterOrange = {fg = "#FFB38C";};
    RainbowDelimiterGreen = {fg = "#ABC896";};
    RainbowDelimiterViolet = {fg = "#BFBFFF";};
    RainbowDelimiterCyan = {fg = "#94D1CE";};
    MiniIconsAzure = {fg = "#68aee8";};
    MiniIconsBlue = {fg = "#57a5e5";};
    MiniIconsCyan = {fg = "#70c2be";};
    MiniIconsGreen = {fg = "#8fb573";};
    MiniIconsGrey = {fg = "#838781";};
    MiniIconsOrange = {fg = "#ff9966";};
    MiniIconsPurple = {fg = "#aaaaff";};
    MiniIconsRed = {fg = "#e75a7c";};
    MiniIconsYellow = {fg = "#dbb651";};
    RainbowRed = {fg = "#E06C75";};
    RainbowYellow = {fg = "#E5C07B";};
    RainbowBlue = {fg = "#61AFEF";};
    RainbowOrange = {fg = "#D19A66";};
    RainbowGreen = {fg = "#98C379";};
    RainbowViolet = {fg = "#C678DD";};
    RainbowCyan = {fg = "#56B6C2";};
    AerialPropertyIcon = {fg = "#70c2be";};
    AerialPackageIcon = {fg = "#dbb651";};
    AerialObjectIcon = {fg = "#e75a7c";};
    AerialNullIcon = {fg = "#5b5e5a";};
    AerialNamespaceIcon = {fg = "#96c7ef";};
    AerialModuleIcon = {fg = "#96c7ef";};
    AerialMethodIcon = {fg = "#57a5e5";};
    AerialKeyIcon = {fg = "#70c2be";};
    AerialInterfaceIcon = {fg = "#8fb573";};
    AerialFolderIcon = {fg = "#96c7ef";};
    AerialFileIcon = {fg = "#8fb573";};
    AerialFieldIcon = {fg = "#70c2be";};
    Repeat = {link = "Keyword";};
    Statement = {fg = "#aaaaff";};
    Macro = {fg = "#df73ff";};
    Error = {fg = "#e75a7c";};
    Label = {
      fg = "#e75a7c";
      bold = true;
    };
    Special = {fg = "#e75a7c";};
    SpecialChar = {link = "Special";};
    Function = {fg = "#57a5e5";};
    Operator = {fg = "#C5C2EE";};
    Tag = {fg = "#57a5e5";};
    Delimiter = {fg = "#838781";};
    Comment = {
      fg = "#838781";
      italic = true;
    };
    SpecialComment = {link = "Comment";};
    Todo = {
      bg = "#aaaaff";
      fg = "#111210";
      bold = true;
    };
    Underlined = {underline = true;};
    Bold = {bold = true;};
    Italic = {italic = true;};
    Strike = {strikethrough = true;};
    AerialEventIcon = {fg = "#dbb651";};
    "@attribute" = {fg = "#70c2be";};
    "@attribute.typescript" = {fg = "#57a5e5";};
    "@boolean" = {link = "Boolean";};
    "@character" = {link = "Character";};
    "@character.special" = {link = "Special";};
    "@comment" = {
      fg = "#e2c792";
      italic = true;
    };
    "@comment.error" = {
      bg = "#e75a7c";
      fg = "#111210";
      bold = true;
    };
    "@comment.note" = {
      bg = "#57a5e5";
      fg = "#111210";
      bold = true;
    };
    "@comment.todo" = {link = "Todo";};
    "@comment.warning" = {
      bg = "#ff9966";
      fg = "#111210";
      bold = true;
    };
    "@comment.warning.gitcommit" = {bg = "#5C4334";};
    "@constant" = {link = "Constant";};
    "@constant.builtin" = {link = "Constant";};
    "@constant.macro" = {link = "Macro";};
    "@constructor" = {
      fg = "#dbb651";
      bold = true;
    };
    "@constructor.lua" = {fg = "#dbb651";};
    "@diff.delta" = {link = "DiffChange";};
    "@diff.minus" = {link = "DiffDelete";};
    "@diff.plus" = {link = "DiffAdd";};
    "@error" = {link = "Error";};
    "@function" = {link = "Function";};
    "@function.builtin" = {fg = "#ff9966";};
    "@function.call" = {link = "Function";};
    "@function.macro" = {fg = "#df73ff";};
    "@function.method" = {link = "Function";};
    "@function.method.call" = {link = "Function";};
    "@keyword" = {link = "Keyword";};
    "@keyword.conditional" = {link = "Conditional";};
    "@keyword.conditional.ternary" = {link = "Operator";};
    "@keyword.coroutine" = {link = "Keyword";};
    "@keyword.debug" = {link = "Keyword";};
    "@keyword.directive" = {link = "PreProc";};
    "@keyword.directive.define" = {
      fg = "#aaaaff";
      bold = true;
    };
    "@keyword.exception" = {link = "Exception";};
    "@keyword.import" = {link = "Include";};
    "@keyword.modifier" = {
      fg = "#aaaaff";
      italic = true;
    };
    "@keyword.operator" = {link = "Keyword";};
    "@keyword.repeat" = {link = "Repeat";};
    "@keyword.return" = {link = "Keyword";};
    "@keyword.type" = {link = "Keyword";};
    "@label" = {link = "Label";};
    "@label.diff" = {fg = "#dbb651";};
    "@markup.heading" = {link = "htmlTitle";};
    BlinkCmpMenu = {link = "NormalFloat";};
    "@markup.heading.1" = {link = "markdownH1";};
    BlinkCmpKindTabNine = {
      fg = "#f1e9d2";
      reverse = false;
    };
    "@markup.heading.2" = {link = "markdownH2";};
    BlinkCmpKindCodeium = {
      fg = "#f1e9d2";
      reverse = false;
    };
    "@markup.heading.3" = {link = "markdownH3";};
    BlinkCmpKindCopilot = {
      fg = "#f1e9d2";
      reverse = false;
    };
    "@markup.heading.4" = {link = "markdownH4";};
    BlinkCmpKind = {
      fg = "#aaaaff";
      reverse = false;
    };
    "@markup.heading.5" = {link = "markdownH5";};
    BlinkCmpLabelDeprecated = {
      fg = "#838781";
      strikethrough = true;
    };
    "@markup.heading.6" = {link = "markdownH6";};
    BlinkCmpLabelMatch = {fg = "#70c2be";};
    "@markup.italic" = {link = "markdownItalic";};
    BlinkCmpLabel = {fg = "#f1e9d2";};
    "@markup.link" = {link = "Tag";};
    "@markup.link.label" = {link = "markdownLinkText";};
    BlinkCmpGhostText = {
      bg = "#252623";
      nocombine = true;
      fg = "#838781";
      italic = true;
    };
    "@markup.link.url" = {link = "markdownUrl";};
    LspInlayHint = {fg = "#5b5e5a";};
    "@markup.list" = {link = "markdownListMarker";};
    LspCodeLensSeparator = {fg = "#5b5e5a";};
    "@markup.list.checked" = {
      fg = "#dbb651";
      bold = true;
    };
    "@markup.list.unchecked" = {
      fg = "#838781";
      bold = true;
    };
    "@markup.math" = {fg = "#96c7ef";};
    "@markup.quote" = {fg = "#838781";};
    "@markup.raw" = {link = "markdownCode";};
    LspCodeLens = {link = "Comment";};
    "@markup.raw.block" = {link = "markdownCodeBlock";};
    LspReferenceRead = {bg = "#383b35";};
    "@markup.strikethrough" = {link = "markdownStrike";};
    DiagnosticWarn = {fg = "#dbb651";};
    "@markup.strong" = {link = "markdownBold";};
    "@lsp.type.selfKeyword" = {link = "@variable.builtin";};
    "@markup.underline" = {link = "htmlUnderline";};
  };
}
