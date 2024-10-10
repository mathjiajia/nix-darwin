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
      "Library/"
      "Movies/"
      "Music/"
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
      "chat-mlx/"

      # website
      "mysite/public/"
      "mysite/static/"
      "mysite/resources/"
      "mysite/themes/"

      # raycast
      ".config/raycast/extensions/"

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
