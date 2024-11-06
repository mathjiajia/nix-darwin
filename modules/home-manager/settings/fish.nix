{
  programs.fish = {
    enable = true;
    interactiveShellInit = # fish
      ''
        set fish_greeting

        # fish_add_path /usr/local/bin
        # fish_add_path /System/Cryptexes/App/usr/bin
        # fish_add_path /usr/bin:/bin:/usr/sbin
        # fish_add_path /sbin
        # fish_add_path /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin
        # fish_add_path /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin
        # fish_add_path /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
        # fish_add_path /Library/TeX/texbin

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
      nl = "vimtex";

      # Delete Apple System Logs
      dasl = "sudo rm -rf /private/var/log/asl/*.asl";
    };
    shellAliases = {
      vimtex = "NVIM_APPNAME=vimtex nvim";
    };
  };

}
