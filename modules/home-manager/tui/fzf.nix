{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    changeDirWidget = {
      command = "${pkgs.fd}/bin/fd --type d --hidden";
      options = [ "--preview 'tree -C {} | head -200'" ];
    };
    defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden";
    defaultOptions = [
      "--border"
      "--layout=reverse"
      "--preview 'bat --color=always --line-range :500 {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    fileWidget.command = "${pkgs.fd}/bin/fd --type f --hidden --follow";
    historyWidget.command = "";
  };
}
