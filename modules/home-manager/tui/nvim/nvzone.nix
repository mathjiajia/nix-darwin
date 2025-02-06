{pkgs, ...}: let
  nvzone-showkeys = pkgs.vimUtils.buildVimPlugin {
    name = "showkeys";
    src = pkgs.fetchFromGitHub {
      owner = "nvzone";
      repo = "showkeys";
      rev = "master";
      sha256 = "0ZONzsCWJzzCYnZpr/O8t9Rmkc4A5+i7X7bkjEk5xmc=";
    };
  };
  nvzone-timerly = pkgs.vimUtils.buildVimPlugin {
    name = "timerly";
    src = pkgs.fetchFromGitHub {
      owner = "nvzone";
      repo = "timerly";
      rev = "master";
      sha256 = "BFIn5InNQT2ZWaaMym1Ct9EEGyA3c2dCF1JLbjduWaw=";
    };
    nvimSkipModule = [
      "timerly"
      "timerly.actions"
      "timerly.layout"
      "timerly.utils"
      "timerly.api"
      "timerly.ui"
    ];
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvchad-ui
    # nvzone-menu
    nvzone-minty
    nvzone-typr
    nvzone-volt

    nvzone-showkeys
    nvzone-timerly
  ];

  # programs.nixvim.keymap = [
  #   {
  #     key = "<C-t>";
  #     action.__raw = ''function() require("menu").open("default") end'';
  #     options.desc = "Menu";
  #   }
  #
  #   {
  #     key = "<RightMouse>";
  #     action.__raw =
  #       # lua
  #       ''
  #         function()
  #         	require('menu.utils').delete_old_menus()
  #
  #         	vim.cmd.exec('"normal! \\<RightMouse>"')
  #
  #         	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  #         	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "gitsigns"
  #
  #         	require("menu").open(options, { mouse = true })
  #         end
  #       '';
  #     options.desc = "Menu";
  #   }
  # ];
}
