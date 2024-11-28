{
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: {
      inherit
        (tpkgs)
        latexindent
        latexmk
        collection-bibtexextra
        collection-fontsextra
        collection-fontsrecommended
        collection-langcjk
        collection-langenglish
        collection-latex
        collection-latexrecommended
        collection-latexextra
        collection-luatex
        collection-mathscience
        collection-pictures
        collection-xetex
        ;
    };
  };
}
