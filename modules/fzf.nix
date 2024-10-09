{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f --strip-cwd-prefix --hidden --follow";
    defaultOptions = [
      "--cycle"
      "--height 90%"
      "--preview 'bat --color=always --line-range :500 {}'"
      "--highlight-line"
      "--info=inline-right"
      "--ansi"
      "--layout=reverse"
      "--border=none"
    ];
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    fileWidgetOptions = [
      "--preview 'head {}'"
    ];
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -n256'"
    ];
  };
}
