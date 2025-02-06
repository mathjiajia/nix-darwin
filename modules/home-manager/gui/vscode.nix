{
  programs.vscode = {
    enable = true;
    userSettings = {
      editor.fontSize = 18;
      editor.minimap.renderCharacters = false;
      editor.minimap.enabled = false;
      editor.formatOnSave = true;
      editor.tabSize = 2;
      files.autoSave = "onFocusChange";
      code-runner.executorMap = {
        lua = "luajit";
        python = "python3";
      };
      code-runner.fileDirectoryAsCwd = true;
      code-runner.runInTerminal = true;
      cSpell.language = "en-GB";
      cSpell.customDictionaries = {
        custom-dictionary-user = {
          name = "Jia_Dict";
          path = "~/.cspell/Jia_Dict.txt";
          addWords = true;
          scope = "user";
        };
      };
      cSpell.ignorePaths = [
        "vscode-extension"
        ".git"
      ];
      latex-workshop.intellisense.citation.backend = "biblatex";
      latex-workshop.latex.recipe.default = "lastUsed";
      # 	 "highlight.regexes": {
      #   "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *TODO(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
      #     "filterFileRegex": ".*(?<!CHANGELOG.md)$",
      #     "decorations": [
      #       {
      #         "overviewRulerColor": "#ffcc00",
      #         "backgroundColor": "#ffcc00",
      #         "color": "#1f1f1f",
      #         "fontWeight": "bold"
      #       },
      #       {
      #         "backgroundColor": "#ffcc00",
      #         "color": "#1f1f1f"
      #       }
      #     ]
      #   },
      #   "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:FIXME|FIX|BUG|UGLY|DEBUG|HACK)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
      #     "filterFileRegex": ".*(?<!CHANGELOG.md)$",
      #     "decorations": [
      #       {
      #         "overviewRulerColor": "#cc0000",
      #         "backgroundColor": "#cc0000",
      #         "color": "#1f1f1f",
      #         "fontWeight": "bold"
      #       },
      #       {
      #         "backgroundColor": "#cc0000",
      #         "color": "#1f1f1f"
      #       }
      #     ]
      #   },
      #   "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:REVIEW|OPTIMIZE|TSC)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
      #     "filterFileRegex": ".*(?<!CHANGELOG.md)$",
      #     "decorations": [
      #       {
      #         "overviewRulerColor": "#00ccff",
      #         "backgroundColor": "#00ccff",
      #         "color": "#1f1f1f",
      #         "fontWeight": "bold"
      #       },
      #       {
      #         "backgroundColor": "#00ccff",
      #         "color": "#1f1f1f"
      #       }
      #     ]
      #   },
      #   "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:IDEA)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
      #     "filterFileRegex": ".*(?<!CHANGELOG.md)$",
      #     "decorations": [
      #       {
      #         "overviewRulerColor": "#cc00cc",
      #         "backgroundColor": "#cc00cc",
      #         "color": "#1f1f1f",
      #         "fontWeight": "bold"
      #       },
      #       {
      #         "backgroundColor": "#cc00cc",
      #         "color": "#1f1f1f"
      #       }
      #     ]
      #   }
      # }
      highlight.regexes = {
        "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *TODO(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))" = {
          filterFileRegex = ".*(?<!CHANGELOG.md)$";
          decorations = [
            {
              overviewRulerColor = "#ffcc00";
              backgroundColor = "#ffcc00";
              color = "#1f1f1f";
              fontWeight = "bold";
            }
            {
              backgroundColor = "#ffcc00";
              color = "#1f1f1f";
            }
          ];
        };
        "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:FIXME|FIX|BUG|UGLY|DEBUG|HACK)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))" = {
          filterFileRegex = ".*(?<!CHANGELOG.md)$";
          decorations = [
            {
              overviewRulerColor = "#cc0000";
              backgroundColor = "#cc0000";
              color = "#1f1f1f";
              fontWeight = "bold";
            }
            {
              backgroundColor = "#cc0000";
              color = "#1f1f1f";
            }
          ];
        };
        "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:REVIEW|OPTIMIZE|TSC)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))" = {
          filterFileRegex = ".*(?<!CHANGELOG.md)$";
          decorations = [
            {
              overviewRulerColor = "#00ccff";
              backgroundColor = "#00ccff";
              color = "#1f1f1f";
              fontWeight = "bold";
            }
            {
              backgroundColor = "#00ccff";
              color = "#1f1f1f";
            }
          ];
        };
        "((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:IDEA)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))" = {
          filterFileRegex = ".*(?<!CHANGELOG.md)$";
          decorations = [
            {
              overviewRulerColor = "#cc00cc";
              backgroundColor = "#cc00cc";
              color = "#1f1f1f";
              fontWeight = "bold";
            }
            {
              backgroundColor = "#cc00cc";
              color = "#1f1f1f";
            }
          ];
        };
      };
    };
    languageSnippets.latex = {
      color-comments = {
        prefix = "color";
        body = ["{\\color{red}$1}$0"];
        description = "color-comments";
      };
      inline-math = {
        prefix = "mk";
        body = ["\\($1\\)$0"];
        description = "inline-math";
      };
      tikz-picture = {
        prefix = "tikzp";
        body = [
          "\\["
          "\\begin{tikzpicture}"
          "\t\\node ($1) at () {},"
          "\t\\draw"
          "\t() edge[->,>=angle 90] node {} ();"
          "\\end{tikzpicture}"
          "\\]"
        ];
        description = "tikz-picture";
      };
      short_exact_seq = {
        prefix = "ses";
        body = ["0\\longrightarrow $1\\longrightarrow $2\\longrightarrow $3\\longrightarrow 0$0"];
        description = "short_exact_seq";
      };
      proj_resolution = {
        prefix = "res";
        body = ["$1\\longrightarrow $2\\longrightarrow $3\\longrightarrow 0$0"];
        description = "right_exact_seq";
      };
    };
  };
}
