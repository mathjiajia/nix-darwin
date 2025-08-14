{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Exclude directories.
      "--glob=!{.cache,.cpan,.git,.local,.Trash}"
      "--glob=!{.docker,.npm,.ollama,.orbstack,.swiftpm,.vscode}"
      "--glob=!{Applications,Library,Movies,Music,Pictures,public,Public,Zotero}"
      "--glob=!{MySite/public,MySite/resources,MySite/themes}"

      # Exclude file types.
      "--glob=!tags"
      "--glob=!viminfo"

      # automatic filtering
      "--hidden"
      # Because who cares about case!?
      "--smart-case"
    ];
  };
}
