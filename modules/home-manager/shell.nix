{ config, lib, pkgs, ... }:
let
  # Fish-only backport of https://github.com/nix-community/home-manager/pull/10076.
  starshipFishInit = pkgs.runCommand "starship-init.fish" { } ''
    substitute "${config.programs.starship.package.shellIntegration}/starship.fish.in" "$out" \
      --replace-fail '::STARSHIP::' '${lib.getExe config.programs.starship.package}'
  '';
in
{
  programs = {
    atuin.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = lib.mkMerge [
        # fish
        ''
          set fish_greeting

          if set -q REX_BIN_DIR
          	fish_add_path --path --prepend --move $REX_BIN_DIR
          end
        ''
        (lib.mkOrder 1500 ''
          if test "$TERM" != dumb
            source ${starshipFishInit}
            ${lib.optionalString config.programs.starship.enableTransience "enable_transience"}
          end
        '')
      ];
      shellAbbrs = {
        mkdir = "mkdir -p";
        nv = "nvim";
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = false;
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
