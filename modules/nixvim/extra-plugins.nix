{ pkgs, ... }:
let
  # math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "math-conceal";
  #   version = "2026-10-10";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "pxwg";
  #     repo = "math-conceal.nvim";
  #     rev = "c456e87c608fa019f8a6e58c35e88161f450ba85";
  #     hash = "sha256-A3UBttqCX2CIb9nqI+jtAmcXIQDUwzUiKf7EgntOAe4=";
  #   };
  # };
  # md-render-nvim = pkgs.vimUtils.buildVimPlugin {
  #   pname = "md-render";
  #   version = "2026-10-26";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "delphinus";
  #     repo = "md-render.nvim";
  #     rev = "v3.11.2";
  #     hash = "sha256-CdGya90aCG3B/EDwskeCCkhTKcx6nJSX/Qae3f/tACM=";
  #   };
  # };
  # scry-nvim = pkgs.vimUtils.buildVimPlugin {
  #   pname = "scry";
  #   version = "0.0.0";
  #   src = pkgs.fetchFromCodeberg {
  #     owner = "vi6jm";
  #     repo = "scry.nvim";
  #     rev = "b643f304751cad6ed9550ddb1b0100e0452b1e6e";
  #     hash = "sha256-riai1B5dtQt661mtXXerExIxgiatfOminUXeH6ksiAA=";
  #   };
  # };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    pname = "latex-conceal";
    version = "2026-11-11";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "4c36206c17b56dbd29ea5bd7dee89590740fae07";
      hash = "sha256-WrjpYDKKeXHyUDuhC3ua+rDa+PNMfcIdz9VASxw1AcM=";
    };
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-11-11";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "c5885baee63d8fe70ae643b7704a12fb20f2af1d";
      hash = "sha256-p5M4IRtv+TJDCQOMpjD+GqlTGVhWenLADf4PqR0NEsQ=";
    };
    nvimSkipModules = [
      "math-snippets.conditions"
      "math-snippets.latex"
    ];
  };
in
{
  extraPlugins = [
    # math-conceal-nvim
    # md-render-nvim
    # scry-nvim
    nvim-latex-conceal
    nvim-math-snippets
  ];

  # plugins = {
  #   lean = {
  #     enable = true;
  #     settings.mappings = true;
  #   };
  # };
}
