{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type directory --hidden";
    changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"];
    defaultCommand = "${pkgs.fd}/bin/fd --type file --hidden";
    defaultOptions = [
      "--border"
      "--height 40%"
      "--layout=reverse"
      "--preview 'bat -n --color=always {} --line-range :400 {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type file --hidden --follow";
    historyWidgetOptions = ["--reverse"];
  };
}
