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
  # math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "math-conceal";
  #   version = "2026-09-04";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "pxwg";
  #     repo = "math-conceal.nvim";
  #     rev = "0c8dc9a63fe8f786333402e12c0b4ed3ae2ae5e1";
  #     hash = "sha256-vMSVb4rgtm9UxkFZkB+r+dudskuyWWsI07p07iDQrug=";
  #   };
  # };
  md-render-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "md-render";
    version = "2026-09-11";
    src = pkgs.fetchFromGitHub {
      owner = "delphinus";
      repo = "md-render.nvim";
      rev = "v3.10.0";
      hash = "sha256-SSh4iJnLkhZXSIZLP+A8RhRnh2pxskM6u6wGdIIH41I=";
    };
  };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    pname = "latex-conceal";
    version = "2026-09-18";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "75312d8f4f816d963f5bd68ef50236e18ab1b2f0";
      hash = "sha256-oloK9fE4GHu91n2pw0BmaFz5N6t9SlT5R0/2qS8QBO0=";
    };
  };
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
    # math-conceal-nvim
    md-render-nvim
    nvim-latex-conceal
    nvim-math-snippets
  ];

  plugins = {
    # lean = {
    #   enable = true;
    #   settings.mappings = true;
    # };
    # render-markdown = {
    #   enable = true;
    #   callSetup = false;
    # };
  };

  # globals.render_markdown_config = {
  #   file_types = [
  #     "markdown"
  #     "quarto"
  #   ];
  #   anti_conceal = {
  #     disabled_modes = [ "n" ];
  #     ignore = {
  #       bullet = true;
  #       code_border = true;
  #       head_background = true;
  #       head_border = true;
  #     };
  #   };
  #   completions.lsp.enabled = true;
  #   heading = {
  #     render_modes = true;
  #     icons = [
  #       " 󰼏 "
  #       " 󰎨 "
  #       " 󰼑 "
  #       " 󰎲 "
  #       " 󰼓 "
  #       " 󰎴 "
  #     ];
  #     border = true;
  #   };
  #   code = {
  #     position = "right";
  #     min_width = 80;
  #     width = "block";
  #     border = "thin";
  #   };
  #   pipe_table = {
  #     alignment_indicator = "─";
  #     border = [
  #       "╭"
  #       "┬"
  #       "╮"
  #       "├"
  #       "┼"
  #       "┤"
  #       "╰"
  #       "┴"
  #       "╯"
  #       "│"
  #       "─"
  #     ];
  #   };
  #   sign.enabled = false;
  #   win_options.concealcursor.rendered = "nvc";
  # };
}
