{pkgs, ...}: let
  nvzone-timerly = pkgs.vimUtils.buildVimPlugin {
    name = "timerly";
    src = pkgs.fetchFromGitHub {
      owner = "nvzone";
      repo = "timerly";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
  nvzone-showkeys = pkgs.vimUtils.buildVimPlugin {
    name = "showkeys";
    src = pkgs.fetchFromGitHub {
      owner = "nvzone";
      repo = "showkeys";
      rev = "master";
      sha256 = "C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvzone-menu
    nvzone-minty
    nvzone-typr
    nvzone-volt

    nvzone-timerly
    nvzone-showkeys
  ];

  programs.nixvim.keymap = [
    {
      key = "<C-t>";
      action.__raw = ''function() require("menu").open("default") end'';
      options.desc = "Menu";
    }

    {
      key = "<RightMouse>";
      action.__raw =
        # lua
        ''
          function()
          	require('menu.utils').delete_old_menus()

          	vim.cmd.exec('"normal! \\<RightMouse>"')

          	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
          	local options = vim.bo.ft == "NvimTree" and "nvimtree" or "gitsigns"

          	require("menu").open(options, { mouse = true })
          end
        '';
      options.desc = "Menu";
    }
  ];
}
