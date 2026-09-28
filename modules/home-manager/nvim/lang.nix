{ pkgs, ... }:
let
  # fk-markdown-nvim = pkgs.vimUtils.buildVimPlugin {
  #   pname = "fk_markdown";
  #   version = "2026-08-30";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "the-mayankjha";
  #     repo = "fk_markdown.nvim";
  #     rev = "v1.4.2";
  #     hash = "sha256-/nRjkhqW2q+nNAxEb6V3CfSggvp0Hpj0vDGyuXReVz4=";
  #   };
  # };
  math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "math-conceal";
    version = "2026-09-23";
    src = pkgs.fetchFromGitHub {
      owner = "pxwg";
      repo = "math-conceal.nvim";
      rev = "173254855f0a98dce7bd7406ca5295366cbbd84a";
      hash = "sha256-6ihC79CLWYfTKKpFUl88o+MsDLaRAcDCUghlCLtpWAk=";
    };
  };
  md-render-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "md-render";
    version = "2026-09-28";
    src = pkgs.fetchFromGitHub {
      owner = "delphinus";
      repo = "md-render.nvim";
      rev = "v3.10.3";
      hash = "sha256-+b/PNIz9sVX1AyLR0BDvL2clfqNSzXpiTfKxo/cTGGE=";
    };
  };
  # nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
  #   pname = "latex-conceal";
  #   version = "2026-09-18";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mathjiajia";
  #     repo = "nvim-latex-conceal";
  #     rev = "75312d8f4f816d963f5bd68ef50236e18ab1b2f0";
  #     hash = "sha256-oloK9fE4GHu91n2pw0BmaFz5N6t9SlT5R0/2qS8QBO0=";
  #   };
  # };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-09-17";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "ffb174b26312046157988a5ea74f743cf06d8b3a";
      hash = "sha256-GHLoAFgrMIMEmOk6R4qUwA7Dr+vY138/C5uvsHrs5nA=";
    };
    nvimSkipModules = [
      "math-snippets.context"
      "math-snippets.latex"
      "math-snippets.position"
      "math-snippets.util"
    ];
  };
in
{
  extraPlugins = [
    # fk-markdown-nvim
    math-conceal-nvim
    md-render-nvim
    # nvim-latex-conceal
    nvim-math-snippets
  ];

  # plugins = {
  #   lean = {
  #     enable = true;
  #     settings.mappings = true;
  #   };
  # };
}
