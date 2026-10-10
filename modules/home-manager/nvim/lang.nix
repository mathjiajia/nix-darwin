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
    version = "2026-10-08";
    src = pkgs.fetchFromGitHub {
      owner = "delphinus";
      repo = "md-render.nvim";
      rev = "v3.11.1";
      hash = "sha256-TesNbPcOJn0sc/BiCygYa0wT/2VyeVHqx4wuKNIjc44=";
    };
  };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    pname = "latex-conceal";
    version = "2026-10-22";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "ae6dfed865fc2e32b33b2ef30a90c71e5a172677";
      hash = "sha256-t2YGxhbw+n3JVcqqQ0WWbhzGKT10jiU2TjmxNrTfhJo=";
    };
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-10-22";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "034d9ee0f44fc8c6a90cf718219ba6e73bb7dedf";
      hash = "sha256-KjDv4IK8zdfYFhcoGcIK0lVbw9OqnY+8j7QlZu0ZuvM=";
    };
    nvimSkipModules = [
      "math-snippets.conditions"
      "math-snippets.latex"
      "math-snippets.util"
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
