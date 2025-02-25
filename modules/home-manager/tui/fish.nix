{
  programs.fish = {
    enable = true;
    interactiveShellInit =
      # fish
      ''
        set fish_greeting
        if set -q GHOSTTY_RESOURCES_DIR
        	source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
        end
        set -x ALIYUN_API_KEY $(security find-generic-password -s "ALIYUN_API_KEY" -w)
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
