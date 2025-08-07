{
  programs.fish = {
    enable = true;
    interactiveShellInit =
      # fish
      ''
        set fish_greeting
        set -x ALIYUN_API_KEY $(security find-generic-password -s "ALIYUN_API_KEY" -w)
        set -x GEMINI_API_KEY $(security find-generic-password -s "GEMINI_API_KEY" -w)
        set -x GOOGLE_CLOUD_PROJECT $(security find-generic-password -s "GOOGLE_CLOUD_PROJECT" -w)
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
