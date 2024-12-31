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
    };
    languageSnippets.latex = {
      #     	"color-comments": {
      # 	"prefix": "color",
      # 	"body": [
      # 		"{\\color{red}$1}$0",
      # 	],
      # 	"description": "color-comments"
      # },
      # "inline-math": {
      # 	"prefix": "mk",
      # 	"body": [
      # 		"\\($1\\)$0",
      # 	],
      # 	"description": "inline-math"
      # },
      # "tikz-picture": {
      # 	"prefix": "tikzp",
      # 	"body": [
      # 		"\\[",
      # 		"\\begin{tikzpicture}",
      # 		"    \\node ($1) at () {},",
      # 		"    \\draw",
      # 		"    () edge[->,>=angle 90] node {} ();",
      # 		"\\end{tikzpicture}",
      # 		"\\]"
      # 	],
      # 	"description": "tikz-picture"
      # },
      # "short_exact_seq": {
      # 	"prefix": "ses",
      # 	"body": [
      # 		"0\\longrightarrow $1\\longrightarrow $2\\longrightarrow $3\\longrightarrow 0$0"
      # 	],
      # 	"description": "short_exact_seq"
      # },
      # "proj_resolution": {
      # 	"prefix": "res",
      # 	"body": [
      # 		"$1\\longrightarrow $2\\longrightarrow $3\\longrightarrow 0$0"
      # 	],
      # 	"description": "short_exact_seq"
      # }

      # convert from the JSON above to nix fmt:
      color-comments = {
        prefix = "color";
        body = [
          "{\\color{red}$1}$0"
        ];
        description = "color-comments";
      };
      inline-math = {
        prefix = "mk";
        body = [
          "\\($1\\)$0"
        ];
        description = "inline-math";
      };
      tikz-picture = {
        prefix = "tikzp";
        body = [
          "\\["
          "\\begin{tikzpicture}"
          "    \\node ($1) at () {},"
          "    \\draw"
          "    () edge[->,>=angle 90] node {} ();"
          "\\end{tikzpicture}"
          "\\]"
        ];
        description = "tikz-picture";
      };
      short_exact_seq = {
        prefix = "ses";
        body = [
          "0\\longrightarrow $1\\longrightarrow $2\\longrightarrow $3\\longrightarrow 0$0"
        ];
        description = "short_exact_seq";
      };
      proj_resolution = {
        prefix = "res";
        body = [
          "$1\\longrightarrow $2\\longrightarrow $3\\longrightarrow 0$0"
        ];
        description = "right_exact_seq";
      };
    };
  };
}
