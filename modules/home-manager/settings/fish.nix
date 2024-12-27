{
  programs.fish = {
    enable = true;
    interactiveShellInit =
      # fish
      ''
        set fish_greeting
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
