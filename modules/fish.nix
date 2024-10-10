{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_add_path -p -m /run/current-system/sw/bin
    '';
    functions = {
      lf = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
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
      nf = "'nvim (fzf)'";
      nl = "vimtex";

      # Delete Apple System Logs
      dasl = "'sudo rm -rf /private/var/log/asl/*.asl'";
    };
    shellAliases = {
      vimtex = "NVIM_APPNAME=vimtex nvim";
    };
  };

}
