{pkgs, ...}: {
  imports = [
    ./settings/bat
    ./settings/git
    ./settings/neovim
    ./settings/yazi

    ./settings/btop.nix
    ./settings/emacs.nix
    ./settings/fastfetch.nix
    ./settings/fish.nix
    ./settings/fzf.nix
    ./settings/texlive.nix
    ./settings/ripgrep.nix
    ./settings/sioyek.nix
    ./settings/starship.nix

    ./configs/aerospace.nix
    ./configs/fd.nix
    ./configs/ghostty.nix
  ];

  home = {
    username = "jia";
    homeDirectory = "/Users/jia";
    stateVersion = "24.11";

    sessionVariables = {
      VISUAL = "nvim";
      MANPAGER = "nvim +Man!";
      DFT_PARSE_ERROR_LIMIT = 999;

      DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
      GEM_HOME = "$XDG_DATA_HOME/gem";
      GEM_SPEC_CACHE = "$XDG_CACHE_HOME/gem";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
    };

    packages = with pkgs; [
      difftastic
      hugo
      onefetch
      python3
      # swift-format
      tree
      unrar
    ];
  };

  programs = {
    home-manager.enable = true; # manage itslef
    fd.enable = true;
    pandoc.enable = true;
    vscode.enable = true;
    zoxide.enable = true;
  };

  # accounts.email.accounts = {
  #   gmail = {
  #     address = "mathjiajia@gmail.com";
  #     primary = true;
  #   };
  #   nus = {
  #     address = "jia_jia@u.nus.edu";
  #   };
  #   thu = {
  #     address = "mathjiajia@tsinghua.edu.cn";
  #     imap = {
  #       host = "mail.tsinghua.edu.cn";
  #       port = 143;
  #       tls.useStartTls = true;
  #     };
  #
  #     smtp = {
  #       host = "mail.tsinghua.edu.cn";
  #       port = 587;
  #       tls.useStartTls = true;
  #     };
  #   };
  # };

  xdg.enable = true;
}
