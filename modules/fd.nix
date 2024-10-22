{ ... }:
{
  programs.fd = {
    enable = true;
    hidden = true;
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

      # system hidden
      ".cache/"
      ".cpan/"
      ".gem/"
      ".git/"
      ".local/"
      ".npm/"
      ".vscode/"
      ".localized"
      ".CFUserTextEncoding"
      ".DS_Store"

      # folders
      "Applications/"
      "Documents/PlaybackEventStreams/"
      "Library/"
      "Movies/"
      "Music/"
      "OrbStack/"
      "Pictures/"
      "Public/"
      "Zotero/"

      ".cargo/"
      ".docker/"
      ".nix-defexpr/"
      ".ollama/"
      ".orbstack/"
      ".prettierd/"
      ".repro/"
      ".swiftpm"
      ".zim"
      "Seafile/"

      # website
      "MySite/public/"
      "MySite/static/"
      "MySite/resources/"
      "MySite/themes/"

      # raycast
      "raycast/extensions/"

      # latex
      "*.otf"
      "*.ttf"
      "*.aux"
      "*.brf"
      "*.blg"
      "*.out"
      "*.synctex.gz"
      "*.toc"

      # latexmk
      "*.bcf"
      "*.dvi"
      "*.fls"
      "*.fdb_latexmk"
      "*.lot"
      "*.pdfsync"
      "*run.xml"
      "*.synctex"
      "*.synctex.gz(busy)"
      "*.xdv"
    ];
  };
}
