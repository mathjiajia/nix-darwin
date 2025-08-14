{
  programs.fd = {
    enable = true;
    ignores = [
      "Library/"
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
      ".diffusionbee/"
      ".gemini/"
      ".git/"
      ".lmstudio/"
      ".local/"
      ".npm/"
      ".nvm"
      ".ollama/"
      ".orbstack/"
      ".vscode/"
      ".DS_Store"

      ".config/raycast/extensions/"

      "MySite/public/"
      "MySite/resources/"
      "MySite/themes/"
    ];
  };
}
