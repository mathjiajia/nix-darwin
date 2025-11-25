{ pkgs, ... }:
let
  # lean-nvim = pkgs.vimUtils.buildVimPlugin {
  #   pname = "lean.nvim";
  #   version = "2025-11-20";
  #   name = "lean-nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Julian";
  #     repo = "lean.nvim";
  #     rev = "621750bb2087088f03712b63a596d4a8e3dfb33c";
  #     sha256 = "1x3paial4rplwva22az3cx4glm7gn97xkxdixc69nn1qd7x9jn60";
  #   };
  #   dependencies = [ pkgs.vimPlugins.plenary-nvim ];
  #   meta.homepage = "https://github.com/Julian/lean.nvim/";
  #   meta.hydraPlatforms = [ ];
  # };
  # math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "math-conceal";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "pxwg";
  #     repo = "math-conceal-nvim";
  #     rev = "master";
  #     sha256 = "";
  #   };
  #   patches = [ ./fix-math-conceal.patch ];
  # };
  nvim-latex-conceal = pkgs.vimUtils.buildVimPlugin {
    name = "latex-conceal";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-latex-conceal";
      rev = "master";
      sha256 = "inPZI+Zyyd6FZpI1iEFeX8qnUQNWDCIGc1N5ubna1pM=";
    };
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    name = "math-snippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "nvim-math-snippets";
      rev = "master";
      sha256 = "cqxQhfhN9TG2zOahURQyqH/Aco07chA/m1GT1MHMR2Q=";
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
    #   package = lean-nvim;
    #   settings.mappings = true;
    # };
    render-markdown = {
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
        latex.enabled = false;
      };
    };
  };

  # extraConfigLua = ''
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
