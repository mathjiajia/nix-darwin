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
    pandoc.enable = true;
    uv.enable = true;
    zoxide.enable = true;
  };

  xdg.enable = true;

  imports = [
    ./tui/git
    ./tui/nvim
    ./tui/yazi

    ./tui/bat.nix
    ./tui/btop.nix
    ./tui/fastfetch.nix
    ./tui/fd.nix
    ./tui/fish.nix
    ./tui/fzf.nix
    ./tui/ripgrep.nix
    ./tui/starship.nix
    ./tui/tex-fmt.nix

    ./gui/aerospace.nix
    # ./gui/kitty.nix
    ./gui/ghostty.nix
    ./gui/neovide.nix
    ./gui/sage.nix
    ./gui/sioyek.nix
    ./gui/zed.nix
  ];
}
