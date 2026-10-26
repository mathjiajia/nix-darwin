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
  md-render-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "md-render";
    version = "2026-10-26";
    src = pkgs.fetchFromGitHub {
      owner = "delphinus";
      repo = "md-render.nvim";
      rev = "v3.11.2";
      hash = "sha256-CdGya90aCG3B/EDwskeCCkhTKcx6nJSX/Qae3f/tACM=";
    };
  };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    pname = "latex-conceal";
    version = "2026-10-26";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "5a5f6f67bac27fa26e034b7ca7a8c54404925950";
      hash = "sha256-+zkJxtXFKqYR5C56S65sAGL1SEgPfQR90g9Kw3VMwWY=";
    };
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-10-23";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "27ff3dcb30fa67877adb2ca1bdbe9669b5cd57e0";
      hash = "sha256-7CRvKHhrw1/KG+OurHirK6xBsycxb5sY4AV/DFLYtrA=";
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
    md-render-nvim
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
