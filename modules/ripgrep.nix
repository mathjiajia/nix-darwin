{ ... }:
{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Don't let ripgrep vomit really long lines to my terminal, and show a preview.
      "--max-columns=150"
      "--max-columns-preview"

      # automatic filtering
      "--hidden"

      # Using glob patterns to include/exclude files or folders
      "--glob=!.cache/"
      "--glob=!.ccnet/"
      "--glob=!.docker/"
      "--glob=!.git/"
      "--glob=!.local/"
      "--glob=!.npm/"
      "--glob=!.ollama/"
      "--glob=!.orbstack/"
      "--glob=!.prettierd/"
      "--glob=!.pretty-clean/"
      "--glob=!.repro/"
      "--glob=!.swiftpm/"
      "--glob=!.zim/"
      "--glob=!.vscode/"
      "--glob=!.Trash/"

      "--glob=!Applications/"
      "--glob=!chat-mlx/"
      "--glob=!Library/"
      "--glob=!Movies/"
      "--glob=!Music/"
      "--glob=!node_modules/"
      "--glob=!Pictures/"
      "--glob=!public/"
      "--glob=!Public/"
      "--glob=!Seafile/"
      "--glob=!themes/"
      "--glob=!Zotero/"

      "--glob=!tags"
      "--glob=!viminfo"

      # Set the colors
      "--colors=match:fg:yellow"
      "--colors=line:none"
      "--colors=line:fg:magenta"
      "--colors=path:fg:blue"
      "--colors=path:style:bold"

      # Because who cares about case!?
      "--smart-case"
    ];
  };
}
