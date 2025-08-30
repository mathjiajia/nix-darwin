{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        editor = {
          fontSize = 18;
          minimap.enabled = false;
          minimap.renderCharacters = false;
          tabSize = 2;
        };
        files.autoSave = "onFocusChange";
        code-runner = {
          executorMap = {
            lua = "luajit";
            python = "python3";
          };
          fileDirectoryAsCwd = true;
          runInTerminal = true;
        };
        latex-workshop = {
          intellisense.citation.backend = "biblatex";
          latex.recipe.default = "lastUsed";
        };
        lldb.library = "/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/LLDB";
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
  };
}
