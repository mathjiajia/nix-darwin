{ lib, pkgs, ... }:
let
  math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "math-conceal";
    version = "2026-08-19";
    src = pkgs.fetchFromGitHub {
      owner = "pxwg";
      repo = "math-conceal.nvim";
      rev = "main";
      hash = "sha256-j0LpwQ+2LwAoBVyd5YrsMrKh7985Ga0DLGIf1d5bSmc=";
    };
  };
  # nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
  #   pname = "latex-conceal";
  #   version = "2026-08-21";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mathjiajia";
  #     repo = "nvim-latex-conceal";
  #     rev = "master";
  #     sha256 = "";
  #   };
  # };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-08-21";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "master";
      hash = "sha256-7uy6A2dSTY/BNd81i6SPQpUmGiXU9u2P6O2s8S+Av7k=";
    };
    nvimSkipModules = [
      "math-snippets.position"
      "math-snippets.context"
      "math-snippets.latex"
    ];
  };
in
{
  extraPlugins = [
    math-conceal-nvim
    # nvim-latex-conceal
    nvim-math-snippets
  ];

  plugins = {
    # lean = {
    #   enable = true;
    #   settings.mappings = true;
    # };
    render-markdown = {
      enable = true;
      luaConfig.content = lib.mkForce "";
    };
  };

  globals.render_markdown_config = {
    file_types = [
      "markdown"
      "quarto"
    ];
    anti_conceal = {
      disabled_modes = [ "n" ];
      ignore = {
        bullet = true;
        code_border = true;
        head_background = true;
        head_border = true;
      };
    };
    completions.lsp.enabled = true;
    heading = {
      render_modes = true;
      icons = [
        " 󰼏 "
        " 󰎨 "
        " 󰼑 "
        " 󰎲 "
        " 󰼓 "
        " 󰎴 "
      ];
      border = true;
    };
    code = {
      position = "right";
      min_width = 80;
      width = "block";
      border = "thin";
    };
    pipe_table = {
      alignment_indicator = "─";
      border = [
        "╭"
        "┬"
        "╮"
        "├"
        "┼"
        "┤"
        "╰"
        "┴"
        "╯"
        "│"
        "─"
      ];
    };
    sign.enabled = false;
    win_options.concealcursor.rendered = "nvc";
  };
}
