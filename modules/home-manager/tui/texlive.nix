{
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      inherit
        (tpkgs)
        scheme-basic
        latexmk
        collection-bibtexextra
        collection-fontsextra
        collection-langcjk
        collection-latexextra
        collection-luatex
        collection-mathscience
        collection-pictures
        collection-xetex
        ;
    };
  };
}
