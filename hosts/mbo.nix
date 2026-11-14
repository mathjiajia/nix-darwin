{
  # Settings specific to mbo.
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager.users.jia.programs.fish = {
    shellInit =
      # fish
      ''
        if set -q SSH_CONNECTION
          fish_add_path --global --path "$HOME/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS"
        end
      '';
    interactiveShellInit =
      # fish
      ''
        if set -q REX_BLOCK
          set -gx PI_CLIPBOARD_OSC52 1
        end
      '';
    functions.codex = {
      wraps = "codex";
      body = ''
        # Forward clipboard copies to the Rex client.
        if set -q REX_BLOCK; and not set -q SSH_TTY
          env SSH_TTY=rex codex $argv
        else
          command codex $argv
        end
      '';
    };
  };

  homebrew.casks = [
    "lobehub"
  ];
}
