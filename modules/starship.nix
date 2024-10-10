{ lib, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$c"
        "$lua"
        "$nix_shell"
        "$python"
        "$swift"
        "$docker_context"
        "$line_break"
        "$character"
      ];
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      git_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      c.symbol = " ";
      lua = {
        # lua_binary = "luajit";
        symbol = " ";
      };
      nix_shell.symbol = " ";
      python.symbol = " ";
      swift.symbol = " ";
    };
  };
}
