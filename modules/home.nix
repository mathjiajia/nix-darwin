{
  config,
  pkgs,
  lib,
  ...
}:
{

  home.username = "jia";
  home.homeDirectory = "/Users/jia";

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ensures ~/Developer folder exists.
  # this folder is later assumed by other activations, specially on darwin.
  home.activation.developer = ''
    mkdir -p ~/Developer
  '';

  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    # sd
    tree

    cargo
    delta
    fastfetch
    lazygit
    neovide
    nodejs
    python3
    tree-sitter
  ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f --strip-cwd-prefix --hidden --follow";
    defaultOptions = [
      "--cycle"
      "--height 90%"
      "--preview 'bat --color=always --line-range :500 {}'"
      "--highlight-line"
      "--info=inline-right"
      "--ansi"
      "--layout=reverse"
      "--border=none"
    ];
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
    fileWidgetOptions = [
      "--preview 'head {}'"
    ];
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -n256'"
    ];
  };

  # yazi file manager
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        ratio = [
          1
          2
          3
        ];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 1200;
        max_height = 1500;
        cache_dir = "${config.xdg.cacheHome}";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs = {
    btop.enable = true;
  };

  xdg.enable = true;
}
