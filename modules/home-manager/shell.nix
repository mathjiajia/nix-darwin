{
  programs = {
    atuin.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = # fish
        ''
          set fish_greeting

          # fish_config theme choose catppuccin-mocha --color-theme=dark

          if set -q REX_BIN_DIR
          	fish_add_path --path --prepend --move $REX_BIN_DIR
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
