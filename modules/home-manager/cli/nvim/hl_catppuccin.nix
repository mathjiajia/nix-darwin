{
	programs.nixvim.highlight = {
		"@function.call" = { link = "Function" ;};
		"@function.macro" = { fg = "#8ec07c" ;};
		"@function.method" = { link = "Function" ;};
		"@function.method.call" = { link = "Function" ;};
		"@constructor" = { fg = "#89b482" ;};
		"@keyword.modifier" = { link = "Keyword" ;};
		"@keyword.type" = { link = "Keyword" ;};
		"@keyword.coroutine" = { link = "Keyword" ;};
		"@keyword.function" = { fg = "#e396a4" ;};
		"@keyword.import" = { link = "Include" ;};
		"@keyword.return" = { fg = "#e396a4" ;};
		"@keyword.exception" = { link = "Exception" ;};
		"@markup.heading.3.markdown" = { link = "rainbow3" ;};
		"@markup.heading.2.markdown" = { link = "rainbow2" ;};
		"@markup.heading.1.markdown" = { link = "rainbow1" ;};
		"@function.builtin.bash" = { italic = true; fg = "#ea6962" ;};
		"@error" = { link = "Error" ;};
		"@tag.delimiter" = { fg = "#99c792" ;};
		"@tag.attribute" = { italic = true; fg = "#8ec07c" ;};
		"@tag" = { fg = "#e396a4" ;};
		"@diff.delta" = { link = "diffChanged" ;};
		"@lsp.type.escapeSequence" = { link = "@string.escape" ;};
		"@string.escape" = { fg = "#d3869b" ;};
		"@lsp.type.formatSpecifier" = { link = "@punctuation.special" ;};
		"@punctuation.special" = { link = "Special" ;};
		"@lsp.type.interface" = { fg = "#eb7a73" ;};
		"@lsp.type.keyword" = { link = "@keyword" ;};
		"@keyword" = { link = "Keyword" ;};
		"@lsp.type.namespace" = { link = "@module" ;};
		"@module" = { italic = true; fg = "#7daea3" ;};
		"@lsp.type.number" = { link = "@number" ;};
		"@number" = { link = "Number" ;};
		"@lsp.type.operator" = { link = "@operator" ;};
		"@operator" = { link = "Operator" ;};
		"@lsp.type.parameter" = { link = "@parameter" ;};
		"@diff.minus" = { link = "diffRemoved" ;};
		"@lsp.type.property" = { link = "@property" ;};
		ColorColumn = { bg = "#292929" ;};
		Conceal = { fg = "#928374" ;};
		Cursor = { bg = "#ebdbb2"; fg = "#1d2021" ;};
		lCursor = { bg = "#ebdbb2"; fg = "#1d2021" ;};
		CursorIM = { bg = "#ebdbb2"; fg = "#1d2021" ;};
		CursorColumn = { bg = "#191b1c" ;};
		CursorLine = { bg = "#252626" ;};
		Directory = { fg = "#83a598" ;};
		EndOfBuffer = { fg = "#1d2021" ;};
		ErrorMsg = { bold = true; italic = true; fg = "#ea6962" ;};
		"@lsp.typemod.enumMember.defaultLibrary" = { link = "@constant.builtin" ;};
		"@constant.builtin" = { fg = "#e78a4e" ;};
		VertSplit = { fg = "#141617" ;};
		Folded = { bg = "#404040"; fg = "#83a598" ;};
		FoldColumn = { fg = "#595959" ;};
		SignColumn = { fg = "#404040" ;};
		SignColumnSB = { fg = "#404040"; bg = "#141617" ;};
		Substitute = { fg = "#d3869b"; bg = "#404040" ;};
		LineNr = { fg = "#404040" ;};
		CursorLineNr = { fg = "#7daea3" ;};
		MatchParen = { bg = "#404040"; bold = true; fg = "#e78a4e" ;};
		ModeMsg = { bold = true; fg = "#ebdbb2" ;};
		MsgSeparator = { };
		MoreMsg = { fg = "#83a598" ;};
		NonText = { fg = "#595959" ;};
		Normal = { bg = "#1d2021"; fg = "#ebdbb2" ;};
		NormalNC = { bg = "#1d2021"; fg = "#ebdbb2" ;};
		AerialBooleanIcon = { link = "@boolean" ;};
		NormalSB = { bg = "#141617"; fg = "#ebdbb2" ;};
		NormalFloat = { bg = "#191b1c"; fg = "#ebdbb2" ;};
		AerialConstructorIcon = { link = "@constructor" ;};
		FloatBorder = { fg = "#83a598" ;};
		FloatTitle = { fg = "#bdae93" ;};
		Pmenu = { fg = "#a89984"; bg = "#252525" ;};
		AerialFunctionIcon = { link = "@function" ;};
		PmenuSel = { bold = true; bg = "#404040" ;};
		PmenuSbar = { bg = "#404040" ;};
		PmenuThumb = { bg = "#595959" ;};
		Question = { fg = "#83a598" ;};
		QuickFixLine = { bold = true; bg = "#404040" ;};
		Search = { fg = "#ebdbb2"; bg = "#425243" ;};
		IncSearch = { fg = "#191b1c"; bg = "#8DB687" ;};
		AerialTypeParameterIcon = { link = "@type" ;};
		AerialPropertyIcon = { link = "@property" ;};
		AerialStringIcon = { link = "@string" ;};
		AerialVariableIcon = { link = "@constant" ;};
		AerialEnumMemberIcon = { link = "@field" ;};
		AerialEnumIcon = { link = "@type" ;};
		AerialFileIcon = { link = "@text.uri" ;};
		"@diff.plus" = { link = "diffAdded" ;};
		AerialModuleIcon = { link = "@namespace" ;};
		AerialPackageIcon = { link = "@namespace" ;};
		AerialInterfaceIcon = { link = "@type" ;};
		AerialStructIcon = { link = "@type" ;};
		AerialEventIcon = { link = "@type" ;};
		AerialArrayIcon = { link = "@constant" ;};
		AerialObjectIcon = { link = "@type" ;};
		AerialKeyIcon = { link = "@type" ;};
		AerialNullIcon = { link = "@type" ;};
		BlinkCmpLabel = { fg = "#a89984" ;};
		BlinkCmpLabelDeprecated = { strikethrough = true; fg = "#595959" ;};
		"@markup.list.unchecked" = { fg = "#928374" ;};
		BlinkCmpKind = { fg = "#83a598" ;};
		BlinkCmpMenu = { fg = "#ebdbb2" ;};
		BlinkCmpMenuBorder = { fg = "#83a598" ;};
		BlinkCmpDocBorder = { fg = "#83a598" ;};
		BlinkCmpSignatureHelpActiveParameter = { fg = "#e396a4" ;};
		BlinkCmpSignatureHelpBorder = { fg = "#83a598" ;};
		BlinkCmpLabelMatch = { bold = true; fg = "#ebdbb2" ;};
		BlinkCmpKindText = { fg = "#a9b665" ;};
		BlinkCmpKindMethod = { fg = "#83a598" ;};
		BlinkCmpKindFunction = { fg = "#83a598" ;};
		BlinkCmpKindConstructor = { fg = "#83a598" ;};
		BlinkCmpKindField = { fg = "#a9b665" ;};
		BlinkCmpKindVariable = { fg = "#eb7a73" ;};
		BlinkCmpKindClass = { fg = "#d8a657" ;};
		BlinkCmpKindInterface = { fg = "#d8a657" ;};
		BlinkCmpKindModule = { fg = "#83a598" ;};
		BlinkCmpKindProperty = { fg = "#83a598" ;};
		BlinkCmpKindUnit = { fg = "#a9b665" ;};
		BlinkCmpKindValue = { fg = "#e78a4e" ;};
		BlinkCmpKindEnum = { fg = "#d8a657" ;};
		BlinkCmpKindKeyword = { fg = "#e396a4" ;};
		BlinkCmpKindSnippet = { fg = "#eb7a73" ;};
		BlinkCmpKindColor = { fg = "#ea6962" ;};
		BlinkCmpKindFile = { fg = "#83a598" ;};
		BlinkCmpKindReference = { fg = "#ea6962" ;};
		BlinkCmpKindFolder = { fg = "#83a598" ;};
		BlinkCmpKindEnumMember = { fg = "#8ec07c" ;};
		BlinkCmpKindConstant = { fg = "#e78a4e" ;};
		BlinkCmpKindStruct = { fg = "#83a598" ;};
		BlinkCmpKindEvent = { fg = "#83a598" ;};
		BlinkCmpKindOperator = { fg = "#99c792" ;};
		BlinkCmpKindTypeParameter = { fg = "#ea6962" ;};
		DapBreakpoint = { fg = "#ea6962" ;};
		DapBreakpointCondition = { fg = "#d8a657" ;};
		DapBreakpointRejected = { fg = "#e396a4" ;};
		DapLogPoint = { fg = "#99c792" ;};
		DapStopped = { fg = "#ea6962" ;};
		DapUIScope = { fg = "#99c792" ;};
		DapUIType = { fg = "#e396a4" ;};
		DapUIValue = { fg = "#99c792" ;};
		DapUIVariable = { fg = "#ebdbb2" ;};
		DapUIModifiedValue = { fg = "#e78a4e" ;};
		DapUIDecoration = { fg = "#99c792" ;};
		DapUIThread = { fg = "#a9b665" ;};
		DapUIStoppedThread = { fg = "#99c792" ;};
		DapUISource = { fg = "#7daea3" ;};
		DapUILineNumber = { fg = "#99c792" ;};
		DapUIFloatBorder = { link = "FloatBorder" ;};
		DapUIWatchesEmpty = { fg = "#ea6962" ;};
		DapUIWatchesValue = { fg = "#a9b665" ;};
		DapUIWatchesError = { fg = "#ea6962" ;};
		DapUIBreakpointsPath = { fg = "#99c792" ;};
		DapUIBreakpointsInfo = { fg = "#a9b665" ;};
		DapUIBreakpointsCurrentLine = { bold = true; fg = "#a9b665" ;};
		DapUIBreakpointsDisabledLine = { fg = "#4d4d4d" ;};
		DapUIStepOver = { fg = "#83a598" ;};
		DapUIStepOverNC = { link = "DapUIStepOver" ;};
		DapUIStepInto = { fg = "#83a598" ;};
		DapUIStepIntoNC = { link = "DapUIStepInto" ;};
		DapUIStepBack = { fg = "#83a598" ;};
		DapUIStepBackNC = { link = "DapUIStepBack" ;};
		DapUIStepOut = { fg = "#83a598" ;};
		DapUIStepOutNC = { link = "DapUIStepOut" ;};
		DapUIStop = { fg = "#ea6962" ;};
		DapUIStopNC = { link = "DapUIStop" ;};
		DapUIPlayPause = { fg = "#a9b665" ;};
		WarningMsg = { fg = "#d8a657" ;};
		DapUIRestart = { fg = "#a9b665" ;};
		DapUIRestartNC = { link = "DapUIRestart" ;};
		DapUIUnavailable = { fg = "#404040" ;};
		DapUIUnavailableNC = { link = "DapUIUnavailable" ;};
		DapUIWinSelect = { fg = "#e78a4e" ;};
		DropBarMenuHoverEntry = { link = "Visual" ;};
		DropBarMenuHoverIcon = { reverse = true ;};
		DropBarMenuHoverSymbol = { bold = true ;};
		DropBarIconUISeparator = { fg = "#928374" ;};
		FlashBackdrop = { fg = "#595959" ;};
		FlashLabel = { bg = "#7daea3"; bold = true; fg = "#a9b665" ;};
		FlashMatch = { bg = "#7daea3"; fg = "#7daea3" ;};
		FlashCurrent = { bg = "#7daea3"; fg = "#e78a4e" ;};
		FlashPrompt = { link = "NormalFloat" ;};
		GrugFarResultsMatch = { link = "IncSearch" ;};
		MiniHipatternsFixme = { bg = "#ea6962"; bold = true; fg = "#1d2021" ;};
		MiniHipatternsHack = { bg = "#d8a657"; bold = true; fg = "#1d2021" ;};
		MiniHipatternsNote = { bg = "#99c792"; bold = true; fg = "#1d2021" ;};
		MiniHipatternsTodo = { bg = "#8ec07c"; bold = true; fg = "#1d2021" ;};
		MiniIconsAzure = { fg = "#89b482" ;};
		MiniIconsBlue = { fg = "#83a598" ;};
		MiniIconsCyan = { fg = "#8ec07c" ;};
		"@markup.list.checked" = { fg = "#a9b665" ;};
		"@markup.list" = { link = "Special" ;};
		"@markup.raw" = { fg = "#8ec07c" ;};
		"@markup.link.url" = { italic = true; underline = true; fg = "#eb7a73" ;};
		"@markup.link.label" = { link = "Label" ;};
		"@markup.link" = { link = "Tag" ;};
		"@markup.environment.name" = { fg = "#83a598" ;};
		"@markup.environment" = { fg = "#d3869b" ;};
		"@markup.quote" = { bold = true; fg = "#ea6962" ;};
		"@markup.math" = { fg = "#83a598" ;};
		"@markup.heading" = { bold = true; fg = "#83a598" ;};
		"@markup.underline" = { link = "Underlined" ;};
		"@markup.strikethrough" = { strikethrough = true; fg = "#ebdbb2" ;};
		"@markup.italic" = { italic = true; fg = "#ea6962" ;};
		"@markup.strong" = { bold = true; fg = "#ea6962" ;};
		"@markup" = { fg = "#ebdbb2" ;};
		"@comment.note" = { bg = "#eb7a73"; fg = "#1d2021" ;};
		"@comment.todo" = { bg = "#eb7a73"; fg = "#1d2021" ;};
		"@comment.hint" = { bg = "#83a598"; fg = "#1d2021" ;};
		"@comment.warning" = { bg = "#d8a657"; fg = "#1d2021" ;};
		"@comment.error" = { bg = "#ea6962"; fg = "#1d2021" ;};
		"@comment.documentation" = { link = "Comment" ;};
		"@keyword.conditional.ternary" = { link = "Operator" ;};
		"@punctuation.bracket" = { fg = "#a89984" ;};
		"@punctuation.delimiter" = { link = "Delimiter" ;};
		"@keyword.export" = { fg = "#99c792" ;};
		"@keyword.directive.define" = { link = "Define" ;};
		"@keyword.directive" = { link = "PreProc" ;};
		CurSearch = { fg = "#191b1c"; bg = "#ea6962" ;};
		SpecialKey = { link = "NonText" ;};
		MiniIconsGreen = { fg = "#a9b665" ;};
		SpellBad = { sp = "#ea6962"; undercurl = true ;};
		MiniIconsOrange = { fg = "#e78a4e" ;};
		MiniIconsPurple = { fg = "#e396a4" ;};
		SpellCap = { sp = "#d8a657"; undercurl = true ;};
		SpellLocal = { sp = "#83a598"; undercurl = true ;};
		SpellRare = { sp = "#a9b665"; undercurl = true ;};
		StatusLine = { bg = "#191b1c"; fg = "#ebdbb2" ;};
		StatusLineNC = { bg = "#191b1c"; fg = "#404040" ;};
		TabLine = { fg = "#595959"; bg = "#141617" ;};
		TabLineFill = { bg = "#191b1c" ;};
		TabLineSel = { link = "Normal" ;};
		TermCursor = { bg = "#eb7a73"; fg = "#1d2021" ;};
		TermCursorNC = { bg = "#a89984"; fg = "#1d2021" ;};
		Title = { bold = true; fg = "#83a598" ;};
		Visual = { bold = true; bg = "#404040" ;};
		VisualNOS = { bold = true; bg = "#404040" ;};
		Whitespace = { fg = "#404040" ;};
		WildMenu = { bg = "#595959" ;};
		WinBar = { fg = "#eb7a73" ;};
		WinBarNC = { link = "WinBar" ;};
		WinSeparator = { fg = "#141617" ;};
		Comment = { italic = true; fg = "#a89984" ;};
		SpecialComment = { link = "Special" ;};
		Special = { fg = "#d3869b" ;};
		Constant = { fg = "#e78a4e" ;};
		String = { fg = "#a9b665" ;};
		Character = { fg = "#8ec07c" ;};
		Number = { fg = "#e78a4e" ;};
		Float = { link = "Number" ;};
		Boolean = { fg = "#e78a4e" ;};
		Identifier = { fg = "#eb7a73" ;};
		Function = { fg = "#83a598" ;};
		Statement = { fg = "#e396a4" ;};
		Conditional = { italic = true; fg = "#e396a4" ;};
		Repeat = { fg = "#e396a4" ;};
		Label = { fg = "#89b482" ;};
		Operator = { fg = "#99c792" ;};
		Keyword = { fg = "#e396a4" ;};
		Exception = { fg = "#e396a4" ;};
		PreProc = { fg = "#d3869b" ;};
		Include = { fg = "#e396a4" ;};
		Define = { link = "PreProc" ;};
		Macro = { fg = "#e396a4" ;};
		PreCondit = { link = "PreProc" ;};
		StorageClass = { fg = "#d8a657" ;};
		Structure = { fg = "#d8a657" ;};
		Type = { fg = "#d8a657" ;};
		Typedef = { link = "Type" ;};
		SpecialChar = { link = "Special" ;};
		Tag = { bold = true; fg = "#7daea3" ;};
		Delimiter = { fg = "#a89984" ;};
		Debug = { link = "Special" ;};
		Underlined = { underline = true ;};
		Bold = { bold = true ;};
		Italic = { italic = true ;};
		Error = { fg = "#ea6962" ;};
		Todo = { bg = "#eb7a73"; bold = true; fg = "#1d2021" ;};
		qfLineNr = { fg = "#d8a657" ;};
		qfFileName = { fg = "#83a598" ;};
		htmlH1 = { bold = true; fg = "#d3869b" ;};
		htmlH2 = { bold = true; fg = "#83a598" ;};
		mkdCodeDelimiter = { fg = "#ebdbb2"; bg = "#1d2021" ;};
		mkdCodeStart = { bold = true; fg = "#eb7a73" ;};
		mkdCodeEnd = { bold = true; fg = "#eb7a73" ;};
		debugPC = { bg = "#141617" ;};
		debugBreakpoint = { fg = "#595959"; bg = "#1d2021" ;};
		illuminatedWord = { bg = "#404040" ;};
		illuminatedCurWord = { bg = "#404040" ;};
		diffAdded = { fg = "#a9b665" ;};
		diffRemoved = { fg = "#ea6962" ;};
		diffChanged = { fg = "#83a598" ;};
		diffOldFile = { fg = "#d8a657" ;};
		diffNewFile = { fg = "#e78a4e" ;};
		diffFile = { fg = "#83a598" ;};
		diffLine = { fg = "#595959" ;};
		diffIndexLine = { fg = "#8ec07c" ;};
		DiffAdd = { bg = "#363B2D" ;};
		DiffChange = { bg = "#242929" ;};
		DiffDelete = { bg = "#422D2D" ;};
		DiffText = { bg = "#3C4845" ;};
		healthError = { fg = "#ea6962" ;};
		healthSuccess = { fg = "#8ec07c" ;};
		healthWarning = { fg = "#d8a657" ;};
		LspReferenceText = { bg = "#404040" ;};
		LspReferenceRead = { bg = "#404040" ;};
		LspReferenceWrite = { bg = "#404040" ;};
		DiagnosticVirtualTextError = { bg = "#302727"; italic = true; fg = "#ea6962" ;};
		DiagnosticVirtualTextWarn = { bg = "#2F2D26"; italic = true; fg = "#d8a657" ;};
		DiagnosticVirtualTextInfo = { bg = "#29302C"; italic = true; fg = "#99c792" ;};
		DiagnosticVirtualTextHint = { bg = "#282F2A"; italic = true; fg = "#8ec07c" ;};
		DiagnosticVirtualTextOk = { bg = "#282F2A"; italic = true; fg = "#a9b665" ;};
		DiagnosticError = { bg = "NONE"; italic = true; fg = "#ea6962" ;};
		DiagnosticWarn = { bg = "NONE"; italic = true; fg = "#d8a657" ;};
		DiagnosticInfo = { bg = "NONE"; italic = true; fg = "#99c792" ;};
		DiagnosticHint = { bg = "NONE"; italic = true; fg = "#8ec07c" ;};
		DiagnosticOk = { bg = "NONE"; italic = true; fg = "#a9b665" ;};
		DiagnosticUnderlineError = { sp = "#ea6962"; underline = true ;};
		DiagnosticUnderlineWarn = { sp = "#d8a657"; underline = true ;};
		DiagnosticUnderlineInfo = { sp = "#99c792"; underline = true ;};
		DiagnosticUnderlineHint = { sp = "#8ec07c"; underline = true ;};
		DiagnosticUnderlineOk = { sp = "#a9b665"; underline = true ;};
		DiagnosticFloatingError = { fg = "#ea6962" ;};
		DiagnosticFloatingWarn = { fg = "#d8a657" ;};
		DiagnosticFloatingInfo = { fg = "#99c792" ;};
		DiagnosticFloatingHint = { fg = "#8ec07c" ;};
		DiagnosticFloatingOk = { fg = "#a9b665" ;};
		DiagnosticSignError = { fg = "#ea6962" ;};
		DiagnosticSignWarn = { fg = "#d8a657" ;};
		DiagnosticSignInfo = { fg = "#99c792" ;};
		DiagnosticSignHint = { fg = "#8ec07c" ;};
		DiagnosticSignOk = { fg = "#a9b665" ;};
		LspDiagnosticsDefaultError = { fg = "#ea6962" ;};
		LspDiagnosticsDefaultWarning = { fg = "#d8a657" ;};
		LspDiagnosticsDefaultInformation = { fg = "#99c792" ;};
		LspDiagnosticsDefaultHint = { fg = "#8ec07c" ;};
		LspSignatureActiveParameter = { bold = true; bg = "#292929" ;};
		LspDiagnosticsError = { fg = "#ea6962" ;};
		LspDiagnosticsWarning = { fg = "#d8a657" ;};
		LspDiagnosticsInformation = { fg = "#99c792" ;};
		LspDiagnosticsHint = { fg = "#8ec07c" ;};
		LspDiagnosticsVirtualTextError = { italic = true; fg = "#ea6962" ;};
		LspDiagnosticsVirtualTextWarning = { italic = true; fg = "#d8a657" ;};
		LspDiagnosticsVirtualTextInformation = { italic = true; fg = "#99c792" ;};
		LspDiagnosticsVirtualTextHint = { italic = true; fg = "#8ec07c" ;};
		LspDiagnosticsUnderlineError = { sp = "#ea6962"; underline = true ;};
		LspDiagnosticsUnderlineWarning = { sp = "#d8a657"; underline = true ;};
		LspDiagnosticsUnderlineInformation = { sp = "#99c792"; underline = true ;};
		LspDiagnosticsUnderlineHint = { sp = "#8ec07c"; underline = true ;};
		LspCodeLens = { fg = "#595959" ;};
		LspCodeLensSeparator = { link = "LspCodeLens" ;};
		LspInlayHint = { bg = "#252626"; fg = "#595959" ;};
		LspInfoBorder = { link = "FloatBorder" ;};
		"@lsp.type.boolean" = { link = "@boolean" ;};
		"@boolean" = { link = "Boolean" ;};
		"@lsp.type.builtinType" = { link = "@type.builtin" ;};
		"@type.builtin" = { fg = "#d8a657" ;};
		"@lsp.type.comment" = { link = "@comment" ;};
		"@comment" = { link = "Comment" ;};
		"@lsp.type.enum" = { link = "@type" ;};
		"@type" = { link = "Type" ;};
		"@lsp.type.enumMember" = { link = "@constant" ;};
		"@constant" = { link = "Constant" ;};
		"@keyword.conditional" = { link = "Conditional" ;};
		"@markup.heading.4.markdown" = { link = "rainbow4" ;};
		"@keyword.debug" = { link = "Exception" ;};
		"@markup.heading.5.markdown" = { link = "rainbow5" ;};
		"@keyword.repeat" = { link = "Repeat" ;};
		"@markup.heading.6.markdown" = { link = "rainbow6" ;};
		"@keyword.operator" = { link = "Operator" ;};
		"@property.toml" = { fg = "#83a598" ;};
		"@label.json" = { fg = "#83a598" ;};
		"@constructor.lua" = { fg = "#eb7a73" ;};
		"@variable.member.yaml" = { fg = "#83a598" ;};
		"@type.builtin.c" = { fg = "#d8a657" ;};
		"@property.cpp" = { fg = "#ebdbb2" ;};
		"@type.builtin.cpp" = { fg = "#d8a657" ;};
		"@comment.warning.gitcommit" = { fg = "#d8a657" ;};
		"@string.special.path.gitignore" = { fg = "#ebdbb2" ;};
		"@function.builtin" = { fg = "#e78a4e" ;};
		"@function" = { link = "Function" ;};
		"@property" = { fg = "#7daea3" ;};
		"@attribute" = { link = "Constant" ;};
		"@type.definition" = { link = "Type" ;};
		"@number.float" = { link = "Float" ;};
		"@character.special" = { link = "SpecialChar" ;};
		"@character" = { link = "Character" ;};
		"@string.special.url" = { italic = true; underline = true; fg = "#eb7a73" ;};
		"@string.special.symbol" = { fg = "#eb7a73" ;};
		"@string.special.path" = { link = "Special" ;};
		"@string.special" = { link = "Special" ;};
		"@string.regexp" = { fg = "#e78a4e" ;};
		"@string.documentation" = { fg = "#8ec07c" ;};
		"@string" = { link = "String" ;};
		"@label" = { link = "Label" ;};
		"@constant.macro" = { link = "Macro" ;};
		"@variable.member" = { fg = "#7daea3" ;};
		"@variable.parameter" = { fg = "#ea6962" ;};
		"@variable.builtin" = { fg = "#ea6962" ;};
		"@variable" = { fg = "#ebdbb2" ;};
		SnacksDashboardTitle = { link = "Title" ;};
		SnacksDashboardSpecial = { link = "Special" ;};
		SnacksDashboardTerminal = { link = "SnacksDashboardNormal" ;};
		SnacksDashboardKey = { fg = "#e78a4e" ;};
		SnacksDashboardIcon = { bold = true; fg = "#d3869b" ;};
		SnacksDashboardHeader = { fg = "#83a598" ;};
		SnacksDashboardFooter = { italic = true; fg = "#d8a657" ;};
		SnacksDashboardDir = { link = "NonText" ;};
		SnacksDashboardFile = { fg = "#7daea3" ;};
		SnacksDashboardDesc = { fg = "#83a598" ;};
		SnacksDashboardNormal = { link = "Normal" ;};
		SnacksNotifierFooterTrace = { link = "DiagnosticHint" ;};
		SnacksNotifierBorderTrace = { fg = "#eb7a73" ;};
		SnacksNotifierTitleTrace = { italic = true; fg = "#eb7a73" ;};
		SnacksNotifierIconTrace = { fg = "#eb7a73" ;};
		SnacksNotifierTrace = { fg = "#eb7a73" ;};
		SnacksNotifierFooterError = { link = "DiagnosticError" ;};
		SnacksNotifierBorderError = { fg = "#ea6962" ;};
		SnacksNotifierTitleError = { italic = true; fg = "#ea6962" ;};
		SnacksNotifierIconError = { fg = "#ea6962" ;};
		SnacksNotifierError = { fg = "#ea6962" ;};
		SnacksNotifierFooterDebug = { link = "DiagnosticHint" ;};
		SnacksNotifierBorderDebug = { fg = "#e78a4e" ;};
		SnacksNotifierTitleDebug = { italic = true; fg = "#e78a4e" ;};
		SnacksNotifierIconDebug = { fg = "#e78a4e" ;};
		SnacksNotifierDebug = { fg = "#e78a4e" ;};
		SnacksNotifierFooterWarn = { link = "DiagnosticWarn" ;};
		SnacksNotifierBorderWarn = { fg = "#d8a657" ;};
		SnacksNotifierTitleWarn = { italic = true; fg = "#d8a657" ;};
		SnacksNotifierIconWarn = { fg = "#d8a657" ;};
		SnacksNotifierWarn = { fg = "#d8a657" ;};
		SnacksNotifierBorderInfo = { fg = "#83a598" ;};
		SnacksNotifierFooterInfo = { link = "DiagnosticInfo" ;};
		SnacksNotifierTitleInfo = { italic = true; fg = "#83a598" ;};
		SnacksNotifierIconInfo = { fg = "#83a598" ;};
		SnacksNotifierInfo = { fg = "#83a598" ;};
		SnacksWinBarNC = { link = "SnacksWinBar" ;};
		SnacksNormalNC = { link = "NormalFloat" ;};
		SnacksBackdrop = { fg = "#595959" ;};
		SnacksWinBar = { link = "Title" ;};
		SnacksNormal = { link = "NormalFloat" ;};
		RainbowDelimiterCyan = { fg = "#8ec07c" ;};
		RainbowDelimiterViolet = { fg = "#e396a4" ;};
		RainbowDelimiterGreen = { fg = "#a9b665" ;};
		RainbowDelimiterOrange = { fg = "#e78a4e" ;};
		RainbowDelimiterBlue = { fg = "#83a598" ;};
		RainbowDelimiterYellow = { fg = "#d8a657" ;};
		RainbowDelimiterRed = { fg = "#ea6962" ;};
		OverseerField = { fg = "#a9b665" ;};
		OverseerComponent = { fg = "#d8a657" ;};
		OverseerOutput = { fg = "#ebdbb2" ;};
		OverseerTaskBorder = { fg = "#99c792" ;};
		OverseerTask = { fg = "#83a598" ;};
		OverseerFAILURE = { fg = "#ea6962" ;};
		OverseerCANCELED = { fg = "#a89984" ;};
		OverseerSUCCESS = { fg = "#a9b665" ;};
		OverseerRUNNING = { fg = "#d8a657" ;};
		OverseerPENDING = { };
		NvimSurroundHighlight = { sp = "#e78a4e"; underline = true ;};
		NoiceMini = { blend = 0; fg = "#ebdbb2" ;};
		NoiceConfirmBorder = { fg = "#83a598" ;};
		NoiceCmdlinePopupBorderSearch = { fg = "#d8a657" ;};
		NoiceCmdlinePopupBorder = { fg = "#7daea3" ;};
		NoiceCmdlineIconSearch = { fg = "#d8a657" ;};
		NoiceCmdlineIcon = { italic = true; fg = "#99c792" ;};
		NoiceCmdline = { fg = "#ebdbb2" ;};
		MiniIconsYellow = { fg = "#d8a657" ;};
		MiniIconsRed = { fg = "#ea6962" ;};
		MiniIconsGrey = { fg = "#ebdbb2" ;};
		DapUIPlayPauseNC = { link = "DapUIPlayPause" ;};
		"@lsp.type.selfKeyword" = { link = "@variable.builtin" ;};
		"@lsp.type.typeAlias" = { link = "@type.definition" ;};
		"@lsp.type.unresolvedReference" = { link = "@error" ;};
		"@lsp.type.variable" = { };
		"@lsp.typemod.class.defaultLibrary" = { link = "@type.builtin" ;};
		"@lsp.typemod.enum.defaultLibrary" = { link = "@type.builtin" ;};
		"@lsp.typemod.function.defaultLibrary" = { link = "@function.builtin" ;};
		"@lsp.typemod.keyword.async" = { link = "@keyword.coroutine" ;};
		"@lsp.typemod.macro.defaultLibrary" = { link = "@function.builtin" ;};
		"@lsp.typemod.method.defaultLibrary" = { link = "@function.builtin" ;};
		"@lsp.typemod.operator.injected" = { link = "@operator" ;};
		"@lsp.typemod.string.injected" = { link = "@string" ;};
		"@lsp.typemod.type.defaultLibrary" = { link = "@type.builtin" ;};
		"@lsp.typemod.variable.defaultLibrary" = { link = "@variable.builtin" ;};
		"@lsp.typemod.variable.injected" = { link = "@variable" ;};
		AerialLine = { bg = "NONE"; fg = "#d8a657" ;};
		AerialGuide = { fg = "#a89984" ;};
		AerialClassIcon = { link = "@type" ;};
		AerialConstantIcon = { link = "@constant" ;};
		AerialFieldIcon = { link = "@field" ;};
		AerialMethodIcon = { link = "@method" ;};
		AerialNamespaceIcon = { link = "@namespace" ;};
		AerialNumberIcon = { link = "@number" ;};
		AerialOperatorIcon = { link = "@operator" ;};
	};

	programs.nixvim.globals = {
		terminal_color_10 = "#a9b665";
		terminal_color_3 = "#d8a657";
		terminal_color_11 = "#d8a657";
		terminal_color_4 = "#83a598";
		terminal_color_12 = "#83a598";
		terminal_color_5 = "#d3869b";
		terminal_color_13 = "#d3869b";
		terminal_color_6 = "#99c792";
		terminal_color_14 = "#99c792";
		terminal_color_7 = "#ebdbb2";
		terminal_color_15 = "#ebdbb2";
		terminal_color_0 = "#595959";
		terminal_color_8 = "#928374";
		terminal_color_1 = "#ea6962";
		terminal_color_9 = "#ea6962";
		terminal_color_2 = "#a9b665";
	};
}