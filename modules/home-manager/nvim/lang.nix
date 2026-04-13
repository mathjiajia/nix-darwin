{ lib, pkgs, ... }:
let
  # math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "math-conceal";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "pxwg";
  #     repo = "math-conceal.nvim";
  #     rev = "main";
  #     hash = "sha256-xMqr7rtqxdb3sFI1bMiubrUbAwNYj65pBwYyYMyf75M=";
  #   };
  # };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    pname = "latex-conceal";
    version = "2025-12-27";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "master";
      hash = "sha256-LoDUCSDyzxiMPgxGjl0RF/xjOQXD/sTodtAL2xRmRzM=";
    };
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2025-12-31";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "master";
      sha256 = "XRRv0UzAbGCfjK1bzGqgNRhAXU5Vg4JbEzQZ2Q+kcZ0=";
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
    # math-conceal-nvim
    nvim-latex-conceal
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
