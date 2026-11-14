{
  programs = {
    atuin.enable = true;

    fish = {
      enable = true;
      interactiveShellInit =
        # fish
        ''
          set fish_greeting
          fish_add_path --prepend --path $HOME/.local/bin

          if set -q REX_BIN_DIR
          	fish_add_path --path --prepend --move $REX_BIN_DIR
          end
        '';
      shellAbbrs.mkdir = "mkdir -p";
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        c.symbol = " ";
        lua.symbol = " ";
        nodejs.symbol = " ";
        python.symbol = " ";
        swift.symbol = " ";
      };
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
  };
}
