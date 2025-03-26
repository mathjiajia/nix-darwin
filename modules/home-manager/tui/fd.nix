{
  programs.fd = {
    enable = true;
    ignores = [
      "Library/"
      "Movies"
      "Music"
      "System/"
      "Volumes/"
      "bin/"
      "dev/"
      "nix/store"
      "opt/"
      "private/"
      "sbin/"
      "tmp/"
      "usr/"
      "var/"
      "Shared/"

      ".bun/"
      ".cache/"
      ".cargo/"
      ".git/"
      ".local/"
      ".npm/"
      ".vscode/"
      ".localized"
      ".DS_Store"

      "Pictures/"
      "Zotero/"

      ".aux/"
      ".diffusionbee/"
      ".cpan/"
      ".lldb/"
      ".lmstudio/"
      ".nix-defexpr/"
      ".nvm"
      ".ollama/"
      ".orbstack/"
      ".prettierd/"

      "lobe-chat-db/"
      "MySite/public/"
      "MySite/static/"
      "MySite/resources/"
      "MySite/themes/"

      ".config/raycast/extensions/"
    ];
  };
}
