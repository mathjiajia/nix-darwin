{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      chouzz.vscode-better-align
      eamodio.gitlens
      efoerster.texlab
      esbenp.prettier-vscode
      fabiospampinato.vscode-highlight
      formulahendry.code-runner
      github.copilot
      github.copilot-chat
      gruntfuggly.todo-tree
      james-yu.latex-workshop
      mathworks.language-matlab
      ms-python.debugpy
      ms-python.python
      ms-python.vscode-pylance
      oderwat.indent-rainbow
      streetsidesoftware.code-spell-checker
      sumneko.lua
      tamasfe.even-better-toml
      valentjn.vscode-ltex
    ];
    userSettings = ''
      {
          	"editor.fontSize": 18,
        "editor.minimap.renderCharacters": false,
          		"editor.minimap.enabled": false,
          		"editor.formatOnSave": true,
          		// Code Runner
          		"code-runner.executorMap": {
          			"lua": "luajit",
          			"python": "python3",
          		},
          		"code-runner.fileDirectoryAsCwd": true,
          		// cSpell
          		"cSpell.language": "en-GB",
          		"cSpell.customDictionaries": {
          			"custom-dictionary-user": {
          				"name": "Jia_Dict",
          				"path": "~/.cspell/Jia_Dict.txt",
          				"addWords": true,
          				"scope": "user"
          			}
          		},
          		"cSpell.ignorePaths": [
          			"vscode-extension", //
          		".git" // Ignore the .git directory
          		],
          		// Latex Workshop
          		"latex-workshop.intellisense.citation.backend": "biblatex",
          		"latex-workshop.latex.recipe.default": "lastUsed",
          		// Highlight TODO
          		"highlight.regexes": {
          			"((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *TODO(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
          				"filterFileRegex": ".*(?<!CHANGELOG.md)$",
          				"decorations": [
          				{
          					"overviewRulerColor": "#ffcc00",
          					"backgroundColor": "#ffcc00",
          					"color": "#1f1f1f",
          					"fontWeight": "bold"
          				},
          				{
          					"backgroundColor": "#ffcc00",
          					"color": "#1f1f1f"
          				}
          				]
          			},
          			"((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:FIXME|FIX|BUG|UGLY|DEBUG|HACK)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
          				"filterFileRegex": ".*(?<!CHANGELOG.md)$",
          				"decorations": [
          				{
          					"overviewRulerColor": "#cc0000",
          					"backgroundColor": "#cc0000",
          					"color": "#1f1f1f",
          					"fontWeight": "bold"
          				},
          				{
          					"backgroundColor": "#cc0000",
          					"color": "#1f1f1f"
          				}
          				]
          			},
          			"((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:REVIEW|OPTIMIZE|TSC)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
          				"filterFileRegex": ".*(?<!CHANGELOG.md)$",
          				"decorations": [
          				{
          					"overviewRulerColor": "#00ccff",
          					"backgroundColor": "#00ccff",
          					"color": "#1f1f1f",
          					"fontWeight": "bold"
          				},
          				{
          					"backgroundColor": "#00ccff",
          					"color": "#1f1f1f"
          				}
          				]
          			},
          			"((?:<!-- *)?(?:#|// @|//|./\\*+|<!--|--|\\* @|{!|{{!--|{{!) *(?:IDEA)(?:\\s*\\([^)]+\\))?:?)((?!\\w)(?: *-->| *\\*/| *!}| *--}}| *}}|(?= *(?:[^:]//|/\\*+|<!--|@|--|{!|{{!--|{{!))|(?: +[^\\n@]*?)(?= *(?:[^:]//|/\\*+|<!--|@|--(?!>)|{!|{{!--|{{!))|(?: +[^@\\n]+)?))": {
          				"filterFileRegex": ".*(?<!CHANGELOG.md)$",
          				"decorations": [
          				{
          					"overviewRulerColor": "#cc00cc",
          					"backgroundColor": "#cc00cc",
          					"color": "#1f1f1f",
          					"fontWeight": "bold"
          				},
          				{
          					"backgroundColor": "#cc00cc",
          					"color": "#1f1f1f"
          				}
          				]
          			}
          		}
          }
    '';
  };
}
