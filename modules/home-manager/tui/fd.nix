{
  programs.fd = {
    enable = true;
    ignores = [
      "Library/"
      "MLXModels/"
      "Movies/"
      "Music/"
      "Pictures/"
      "Volumes/"
      "Zotero/"

      ".aux/"
      ".bun/"
      ".cache/"
      ".cargo/"
      ".cpan/"
      ".elan/"
      ".gemini/"
      ".git/"
      ".jupyter/"
      ".llamabarn/"
      ".lmstudio/"
      ".local/"
      ".npm/"
      ".ollama/"
      ".orbstack/"
      ".sage/"
      ".swiftpm/"
      ".vscode/"
      ".DS_Store"

      ".config/raycast/extensions/"

      "MySite/public/"
      "MySite/resources/"
      "MySite/themes/"
    ];
  };
}
