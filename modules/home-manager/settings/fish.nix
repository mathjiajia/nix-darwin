{
  programs.fish = {
    enable = true;
    interactiveShellInit = # fish
      ''
        set fish_greeting
        fish_add_path --append $GHOSTTY_BIN_DIR
        if set -q GHOSTTY_RESOURCES_DIR
            source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
            set --prepend fish_complete_path "$GHOSTTY_RESOURCES_DIR/../fish/vendor_completions.d"
        end
      '';
    shellAbbrs = {
      mkdir = "mkdir -p";

      # Git
      gd = "git diff";
      gP = "git push";
      gp = "git pull";
      gl = "git log";
      glp = "git log --patch";

      # LazyGit
      lg = "lazygit";

      # Nvim
      nv = "nvim";
      nf = "nvim (fzf)";
    };
  };

}
