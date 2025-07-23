{
  home = {
    username = "jia";
    homeDirectory = "/Users/jia";
    stateVersion = "25.11";
  };

  programs = {
    home-manager.enable = true; # manage itslef

    atuin.enable = true;
    bun.enable = true;
    opencode.enable = true;
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

    tex-fmt.enable = true;
    tex-fmt.settings = {
      tabchar = "tab";
      tabsize = 1;
      wraplen = 120;
    };

    zoxide.enable = true;
    zoxide.options = ["--cmd" "cd"];
  };

  xdg.enable = true;

  imports = [
    ./tui/git
    ./tui/nvim
    ./tui/yazi

    ./tui/fastfetch.nix
    ./tui/fd.nix
    ./tui/fish.nix
    ./tui/fzf.nix
    ./tui/ripgrep.nix
    ./tui/starship.nix

    ./gui/aerospace.nix
    # ./gui/kitty.nix
    ./gui/ghostty.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
  ];
}
