{ inputs, pkgs, ... }:
{
  programs = {
    atuin = {
      enable = true;
      package = inputs.nixpkgs-small.legacyPackages.${pkgs.stdenv.hostPlatform.system}.atuin;
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
      shellAbbrs = {
        gd = "git diff";
        gP = "git push";
        gp = "git pull";
        mkdir = "mkdir -p";

        lg = "lazygit";
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
