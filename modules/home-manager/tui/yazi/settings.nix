{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    imagemagick
    poppler
    resvg
  ];

  programs.yazi.settings = {
    log.enabled = false;
    mgr = {
      linemode = "size_and_mtime";
      ratio = [
        1
        3
        2
      ];
      sort_by = "natural";
      sort_sensitive = true;
    };

    preview = {
      max_height = 5000;
      max_width = 5000;
    };

    opener.sioyek = [
      {
        run = ''sioyek "$1"'';
        orphan = true;
        for = "unix";
      }
    ];

    open.prepend_rules = [
      {
        mime = "application/pdf";
        use = [
          "sioyek"
          "reveal"
        ];
      }
    ];

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

      prepend_previewers = [
        {
          mime = "application/pdf";
          run = "pdf";
        }
      ];
      prepend_preloaders = [
        {
          name = "/Volumes/**";
          run = "noop";
        }
        {
          mime = "application/pdf";
          run = "noop";
        }
      ];

    };
  };
}
