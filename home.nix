{ config, pkgs, ... }:
{

  home.username = "jia";
  home.homeDirectory = "/Users/jia";

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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

  # Programs natively supported by home-manager.
  # They can be configured in `programs.*` instead of using home.packages.
  programs.bat = {
    enable = true;
    config = {
      theme = "bamboo";
      italic-text = "always";
      style = "numbers,changes,header";
    };
  };

  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      "System/"
      "Volumes/"
      "bin/"
      "cores/"
      "dev/"
      "etc/"
      "opt/"
      "private/"
      "sbin/"
      "tmp/"
      "usr/"
      "var/"
      "Shared/"

      # system hidden
      ".cache/"
      ".cpan/"
      ".gem/"
      ".git/"
      ".local/"
      ".npm/"
      ".vscode/"
      ".localized"
      ".CFUserTextEncoding"
      ".DS_Store"

      # folders
      "Applications/"
      "Library/"
      "Movies/"
      "Music/"
      "Pictures/"
      "Public/"
      "Zotero/"

      ".cargo/"
      ".docker/"
      ".nix-defexpr/"
      ".ollama/"
      ".orbstack/"
      ".prettierd/"
      ".repro/"
      ".swiftpm"
      ".zim"
      "Seafile/"
      "chat-mlx/"

      # website
      "mysite/public/"
      "mysite/static/"
      "mysite/resources/"
      "mysite/themes/"

      # raycast
      ".config/raycast/extensions/"

      # latex
      "*.otf"
      "*.ttf"
      "*.aux"
      "*.brf"
      "*.blg"
      "*.out"
      "*.synctex.gz"
      "*.toc"

      # latexmk
      "*.bcf"
      "*.dvi"
      "*.fls"
      "*.fdb_latexmk"
      "*.lot"
      "*.pdfsync"
      "*run.xml"
      "*.synctex"
      "*.synctex.gz(busy)"
      "*.xdv"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Jia Jia";
    userEmail = "mathjiajia@outlook.com";
    extraConfig = {
      github.user = "mathyjiajia";
      init = {
        defaultBranch = "trunk";
      };
      diff = {
        external = "${pkgs.difftastic}/bin/difft";
      };
    };
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

  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };

  programs = {
    btop.enable = true;
    fzf.enable = true;
  };

  xdg.enable = true;

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./home-modules/bat-themes;
    onChange = "${pkgs.bat} cache --build";
  };
}
