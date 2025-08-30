{
  home = {
    stateVersion = "25.11";
    sessionPath = ["/Library/TeX/texbin"];
    sessionVariables = {
      # ALIYUN_API_KEY = "$(security find-generic-password -s 'ALIYUN_API_KEY' -w)";
      GEMINI_API_KEY = "$(security find-generic-password -s 'GEMINI_API_KEY' -w)";
    };
  };

  programs = {
    home-manager.enable = true; # manage itslef

    atuin.enable = true;
    bun.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    pandoc.enable = true;
    uv.enable = true;

    bat.enable = true;
    bat.config = {
      theme = "Visual Studio Dark+";
      italic-text = "always";
      style = "numbers,changes,header";
    };

    btop.enable = true;
    btop.settings = {
      theme_background = false;
      vim_keys = true;
    };

    nushell.enable = true;
    nushell.settings.show_banner = false;

    tex-fmt.enable = true;
    tex-fmt.settings = {
      tabchar = "tab";
      tabsize = 1;
      wraplen = 120;
    };

    zoxide.enable = true;
    zoxide.options = ["--cmd" "cd"];

    zsh.enable = true;
    zsh.autosuggestion.enable = true;
    zsh.syntaxHighlighting.enable = true;
  };

  xdg.enable = true;

  imports = [
    ./tui/git
    ./tui/nvim
    ./tui/yazi

    ./tui/fd.nix
    ./tui/fzf.nix
    ./tui/ripgrep.nix
    ./tui/starship.nix

    ./gui/aerospace.nix
    ./gui/ghostty.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
  ];
}
