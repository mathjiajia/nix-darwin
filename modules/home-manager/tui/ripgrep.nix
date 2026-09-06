{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Exclude directories.
      "--glob=!{.cache,.git,.local,.Trash}"
      "--glob=!{.agent-browser,.aux,.build,.bun,.cargo,.codex,.copilot,.cpan,.craft-agent,.cumora,.cups,.elan,.gemini,.lmstudio,.npm,.ollama,.orbstack,.osaurus,.sage,.vene}"
      "--glob=!{.config/raycast/extensions,.vscode/extensions}"
      "--glob=!{Applications,Library,MLXModels,Movies,Music,Pictures,Volumes,Zotero}"
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
