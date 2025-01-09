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

      ".aux/"
      ".cpan/"
      ".docker/"
      ".jupyter/"
      ".lldb/"
      ".nix-defexpr/"
      ".nuget/"
      ".ollama/"
      ".orbstack/"
      ".prettierd/"
      ".swiftpm/"

      "MySite/public/"
      "MySite/static/"
      "MySite/resources/"
      "MySite/themes/"

      ".config/raycast/extensions/"
    ];
  };
}
