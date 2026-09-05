{ lib, pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    changeDirWidget = {
      command = "${lib.getExe pkgs.fd} --type d --hidden";
      options = [ "--preview '${lib.getExe pkgs.eza} -T {} | head -200'" ];
    };
    defaultCommand = "${lib.getExe pkgs.fd} --type f --hidden";
    defaultOptions = [
      "--border"
      "--layout=reverse"
      "--preview 'bat --color=always --line-range :500 {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];
    fileWidget.command = "${lib.getExe pkgs.fd} --type f --hidden --follow";
    historyWidget.command = "";
  };
}
