{
  programs.fd = {
    enable = true;
    ignores = [
      "System/"
      "Volumes/"
      "bin/"
      "cores/"
      "dev/"
      "etc/"
      "opt/"
      "private/"
      "sbin/"
      "tmp/"
      "usr/"
      "var/"
      "Shared/"

      ".cache/"
      ".git/"
      ".local/"
      ".npm/"
      ".vscode/"
      ".localized"
      ".CFUserTextEncoding"
      ".DS_Store"

      "Applications/"
      "Documents/PlaybackEventStreams/"
      "Library/"
      "Movies/"
      "Music/"
      "OrbStack/"
      "Pictures/"
      "Public/"
      "Zotero/"

      ".cpan/"
      ".cargo/"
      ".docker/"
      ".gem/"
      ".nix-defexpr/"
      ".ollama/"
      ".orbstack/"
      ".prettierd/"
      ".repro/"
      ".swiftpm"
      ".zim"

      "# website"
      "MySite/public/"
      "MySite/static/"
      "MySite/resources/"
      "MySite/themes/"

      "raycast/extensions/"
    ];
  };
}
