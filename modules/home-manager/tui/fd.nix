{
  programs.fd = {
    enable = true;
    ignores = [
      "Applications/"
      "Library/"
      "MLXModels/"
      "Movies/"
      "Music/"
      "Pictures/"
      "Volumes/"
      "Zotero/"

      ".cache/"
      ".git/"
      ".local/"
      ".Trash/"
      ".DS_Store"

      ".agent-browser/"
      ".aux/"
      ".build/"
      ".bun/"
      ".cargo/"
      ".codex/"
      ".copilot/"
      ".cpan/"
      ".craft-agent/"
      ".cumora/"
      ".cups/"
      ".elan/"
      ".gemini/"
      ".lmstudio/"
      ".npm/"
      ".ollama/"
      ".orbstack/"
      ".osaurus/"
      ".sage/"
      ".vscode/extensions/"

      ".config/raycast/extensions/"

      "MySite/public/"
      "MySite/resources/"
      "MySite/themes/"
    ];
  };
}
