{ lib, pkgs, ... }:
{
  programs = {
    atuin = {
      enable = true;
      package = pkgs.atuin.overrideAttrs (oldAttrs: {
        checkFlags =
          (oldAttrs.checkFlags or [ ])
          ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
            # Host Node/Bun processes can look like live Pi sessions to the Darwin build user.
            "--skip=a_diverged_copy_resumes_only_as_chosen::agent_4_Agent__Pi"
            "--skip=a_session_gone_on_with_elsewhere_catches_up_where_it_came_from::agent_3_Agent__Pi"
          ];
      });
    };

    fish = {
      enable = true;
      interactiveShellInit =
        # fish
        ''
          set fish_greeting

          if set -q REX_BIN_DIR
          	fish_add_path --path --prepend --move $REX_BIN_DIR
          end

          # Load completions from the app-provided Rex CLI.
          if type -q rex
            rex completion fish | source
          end
        '';
      shellAbbrs = {
        mkdir = "mkdir -p";
        nv = "nvim";
      };
    };

    starship = {
      enable = true;
      settings.add_newline = false;
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
