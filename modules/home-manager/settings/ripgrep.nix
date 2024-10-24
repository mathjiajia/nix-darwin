{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Filetypes
      "--type-add=l:*.lua"
      "--type-add=m:*.md"
      "--type-add=p:*.py"
      "--type-add=s:*.sh"
      "--type-add=t:*.tex"

      # Exclude directories.
      "--glob=!{System,Volumes,bin,cores,dev,etc,opt,private,sbin,tmp,usr,var,Shared}"
      "--glob=!{.cache,.cpan,.git,.local,.Trash}"
      "--glob=!{.docker,.gem,.npm,.ollama,.orbstack,.prettierd,.pretty-clean,.swiftpm,.vscode}"
      "--glob=!{Applications,Library,/Users/jia/Library,Movies,Music,Pictures,public,Public,Zotero}"
      "--glob=!{MySite/public,MySite/static,MySite/resources,MySite/themes}"

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
