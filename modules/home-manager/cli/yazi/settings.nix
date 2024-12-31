{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ffmpeg
    imagemagick
    poppler
  ];

  programs.yazi.settings = {
    manager = {
      ratio = [1 2 3];
      sort_by = "natural";
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
      cache_dir = "${config.xdg.cacheHome}/yazi";
    };

    plugin = {
      prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}
