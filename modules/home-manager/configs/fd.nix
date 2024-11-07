{
  home.file.fd = {
    target = ".config/fd/ignore";
    text =
      # ignore
      ''
        System/
        Volumes/
        bin/
        cores/
        dev/
        etc/
        opt/
        private/
        sbin/
        tmp/
        usr/
        var/
        Shared/

        # system hidden
        .cache/
        .git/
        .local/
        .npm/
        .vscode/
        .localized
        .CFUserTextEncoding
        .DS_Store

        # folders
        Applications/
        Documents/PlaybackEventStreams/
        Library/
        Movies/
        Music/
        OrbStack/
        Pictures/
        Public/
        Zotero/

        .cpan/
        .cargo/
        .docker/
        .gem/
        .nix-defexpr/
        .ollama/
        .orbstack/
        .prettierd/
        .repro/
        .swiftpm
        .zim

        # website
        MySite/public/
        MySite/static/
        MySite/resources/
        MySite/themes/

        # raycast
        raycast/extensions/
      '';
  };
}
