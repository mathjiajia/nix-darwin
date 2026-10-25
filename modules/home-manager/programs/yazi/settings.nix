{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg # for video thumbnails
    imagemagick # for Font, HEIC, and JPEG XL preview
    poppler # for PDF preview
    resvg # for SVG preview
  ];

  programs.yazi.settings = {
    log.enabled = false;
    # Keep automatic preview jobs out of the task list and quit confirmation.
    # tasks.suppress_preload = true;
    mgr = {
      linemode = "size_and_mtime";
      ratio = [
        1
        3
        2
      ];
      sort_by = "natural";
    };

    preview = {
      max_height = 2700;
      max_width = 1800;
    };

    plugin.prepend_fetchers = [
      {
        url = "*";
        run = "git";
        group = "git";
      }
      {
        url = "*/";
        run = "git";
        group = "git";
      }
    ];

  };
}
