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
    version = "2026-11-18";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "3d034b08d0fe651d371659141543301630a0b82e";
      hash = "sha256-HwviSqNbM33mZbZwFEBH/ae8+CslZSUjlk1RrBGXpZo=";
    };
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-11-18";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "600243a3245d93c186b1bed7a4debb47e71d5936";
      hash = "sha256-pY0YGkNlCMRHqxJdfRtD/pPELRmlYlvP6PRMrCPkJDM=";
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

  # Local scry.nvim checkout for testing; edits apply on the next Neovim start.
  # extraConfigLuaPre = ''
  #   local scry = vim.fn.expand("~/Projects/scry.nvim")
  #   if vim.uv.fs_stat(scry) then
  #   	vim.opt.runtimepath:prepend(scry)
  #   end
  # '';

  # plugins = {
  #   lean = {
  #     enable = true;
  #     settings.mappings = true;
  #   };
  # };
}
