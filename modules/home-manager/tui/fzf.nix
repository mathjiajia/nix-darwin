{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d --hidden";
    changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"];
    defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden";
    defaultOptions = [
      "--border"
      "--layout=reverse"
      "--preview 'bat --color=always --line-range :500 {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f --hidden --follow";
    historyWidgetOptions = ["--reverse"];
  };
}
