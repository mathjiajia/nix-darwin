{ config, pkgs, ... }:
{
  home = {
    stateVersion = "25.11";
    sessionPath = [ "/Library/TeX/texbin" ];
    sessionVariables = {
      # ALIYUN_API_KEY = "$(security find-generic-password -s 'ALIYUN_API_KEY' -w)";
      GEMINI_API_KEY = "$(security find-generic-password -s 'GEMINI_API_KEY' -w)";
    };

    packages = with pkgs; [
      # CLI
      container
      crush
      elan # lean
      hugo
      luajit

      # PYTHON
      (python3.withPackages (ps: [ ps.jupyterlab ]))
    ];
  };

  programs = {
    home-manager.enable = true; # manage itslef

    atuin.enable = true;
    bun.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    pandoc.enable = true;
    uv.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "Visual Studio Dark+";
        italic-text = "always";
        style = "numbers,changes,header";
      };
    };

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    nh = {
      enable = true;
      flake = "/etc/nix-darwin";
    };

    tex-fmt = {
      enable = true;
      settings = {
        tabchar = "tab";
        tabsize = 1;
        wraplen = 120;
      };
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      syntaxHighlighting.enable = true;
    };
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

    # ./gui/aerospace.nix
    ./gui/ghostty.nix
    ./gui/neovide.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
  ];
}
