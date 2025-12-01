{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Exclude directories.
      "--glob=!{.cache,.docker,.git,.local,.swiftpm,.Trash}"
      "--glob=!{.bun,.cargo,.cpan,.elan,.gemini,.jupyter,.npm,.ollama,.orbstack}"
      "--glob=!{.config/raycast/extensions,.vscode/extensions}"
      "--glob=!{Applications,Library,MLXModels,Movies,Music,Pictures,public,Public,Volumes,Zotero}"
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
