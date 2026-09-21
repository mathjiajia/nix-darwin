{ lib, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    changeDirWidget = {
      command = "${lib.getExe pkgs.fd} --type d";
      options = [ "--preview '${lib.getExe pkgs.eza} -T {} | head -200'" ];
    };
    defaultCommand = "${lib.getExe pkgs.fd} --type f";
    defaultOptions = [
      "--border"
      "--layout=reverse"
      "--color=base16"
    ];
    fileWidget.command = "${lib.getExe pkgs.fd} --type f --follow";
    historyWidget.command = "";
  };
}
