{
  programs = {
    nushell.enable = true;

    atuin = {
      enable = true;
      daemon.enable = true;
      # flags = [ "--bind-ai-resume" ]; seems auto?
      settings = {
        auto_sync = true;
        enter_accept = true;
        daemon = {
          # Home Manager manages the launchd service.
          autostart = false;
          sync_frequency = 300;
        };
        ai.enabled = true;
        threads.capture = true;
      };
    };

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
