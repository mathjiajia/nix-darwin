{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg # for video thumbnails
    imagemagick # for Font, HEIC, and JPEG XL preview
    poppler # for PDF preview
    resvg # for SVG preview
  ];

  programs.yazi.settings = {
    log.enabled = false;
    mgr.sort_by = "natural";

    preview = {
      max_height = 1800;
      max_width = 1200;
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
