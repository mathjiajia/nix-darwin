{
  # Settings specific to mbo.
  home-manager.users.jia.programs.fish = {
    interactiveShellInit =
      # fish
      ''
        if set -q REX_BLOCK
          set -gx PI_CLIPBOARD_OSC52 1
        end
      '';
    functions.codex = {
      wraps = "codex";
      body = # fish
        ''
          # Forward clipboard copies to the Rex client.
          if set -q REX_BLOCK; and not set -q SSH_TTY
            env SSH_TTY=rex codex $argv
          else
            command codex $argv
          end
        '';
    };
  };

  home-manager.users.jia.programs.nushell.extraConfig = # nu
    ''
      if "REX_BLOCK" in $env {
        $env.PI_CLIPBOARD_OSC52 = "1"
      }

      @complete external
      def --wrapped codex [...args: string] {
        if "REX_BLOCK" in $env and "SSH_TTY" not-in $env {
          SSH_TTY=rex ^codex ...$args
        } else {
          ^codex ...$args
        }
      }
    '';

  homebrew.casks = [ "lobehub" ];
}
