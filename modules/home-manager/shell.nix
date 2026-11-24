{ config, ... }:
{
  programs = {
    nushell = {
      enable = true;
      settings = {
        show_banner = false;
        abbreviations = config.programs.fish.shellAbbrs // {
          mkdir = "^mkdir -p";
        };
      };
      extraConfig = # nu
        ''
          let local_bin = ($env.HOME | path join ".local/bin")
          if $local_bin not-in $env.PATH and ($local_bin | path expand | path type) == dir {
            $env.PATH = ($env.PATH | prepend $local_bin)
          }
          if ($env.REX_BIN_DIR? | is-not-empty) {
            let rex_bin = ($env.REX_BIN_DIR | path expand --no-symlink)
            if ($rex_bin | path expand | path type) == dir {
              $env.PATH = ($env.PATH | where {|dir| $dir != $rex_bin } | prepend $rex_bin)
            }
          }
        '';
    };

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
