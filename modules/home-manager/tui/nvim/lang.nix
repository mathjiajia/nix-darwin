{ inputs, pkgs, ... }:
let
  # math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "math-conceal";
  #   src = inputs.math-conceal-nvim;
  #   patches = [./fix-math-conceal.patch];
  # };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    name = "latex-conceal";
    src = inputs.nvim-latex-conceal;
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    name = "math-snippets";
    src = inputs.nvim-math-snippets;
    nvimSkipModules = [
      "math-snippets.position"
      "math-snippets.context"
      "math-snippets.latex"
    ];
  };
in
{
  programs.nixvim.extraPlugins = [
    # math-conceal-nvim
    nvim-latex-conceal
    nvim-math-snippets
  ];

  # programs.nixvim.plugins.lean.enable = true;

  # programs.nixvim.extraPython3Packages = p: [p.pylatexenc];
  programs.nixvim.plugins.render-markdown = {
    enable = true;
    settings = {
      file_types = [
        "markdown"
        "codecompanion"
        "quarto"
      ];
      sign.enabled = false;
      code = {
        position = "right";
        min_width = 80;
        width = "block";
        border = "thin";
      };
      heading = {
        icons = [
          " 󰼏 "
          " 󰎨 "
          " 󰼑 "
          " 󰎲 "
          " 󰼓 "
          " 󰎴 "
        ];
        border = true;
        render_modes = true;
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
      anti_conceal = {
        disabled_modes = [ "n" ];
        ignore = {
          bullet = true;
          head_border = true;
          head_background = true;
        };
      };
      win_options.concealcursor.rendered = "nvc";
      completions.lsp.enabled = true;
    };
  };

  # programs.nixvim.extraConfigLua = ''
  #   require("math-conceal").setup({
  #   	conceal = {
  #   		"greek",
  #   		"script",
  #   		"math",
  #   		"font",
  #   		"delim",
  #   	},
  #   })
  # '';
}
