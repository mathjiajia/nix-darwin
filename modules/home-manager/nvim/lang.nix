{ lib, pkgs, ... }:
let
  math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "math-conceal";
    version = "2026-08-19";
    src = pkgs.fetchFromGitHub {
      owner = "pxwg";
      repo = "math-conceal.nvim";
      rev = "0c8dc9a63fe8f786333402e12c0b4ed3ae2ae5e1";
      hash = "sha256-vMSVb4rgtm9UxkFZkB+r+dudskuyWWsI07p07iDQrug=";
    };
  };
  # nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
  #   pname = "latex-conceal";
  #   version = "2026-08-21";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "mathjiajia";
  #     repo = "nvim-latex-conceal";
  #     rev = "afd988ae0be7883749d44b0084be3bb39188dea0";
  #     hash = "sha256-JeJS5Ah4v/QHWyyJcKkKI7CjdNHrjVhO68uyczLpGOY=";
  #   };
  # };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    pname = "math-snippets";
    version = "2026-08-21";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "8e3cdf5b7d6daff503f6243974250daffe00ad37";
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
