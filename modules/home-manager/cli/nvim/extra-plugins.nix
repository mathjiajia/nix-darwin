{pkgs, ...}: let
  mysnippets = pkgs.vimUtils.buildVimPlugin {
    name = "mySnippets";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "mySnippets";
      rev = "master";
      sha256 = "8ZbQ7pOrz8siT/jThLZuL+EKChPS0s5YO7GwA+5UARU=";
    };
  };

  latex-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "latex";
    src = pkgs.fetchFromGitHub {
      owner = "mathjiajia";
      repo = "latex.nvim";
      rev = "master";
      sha256 = "vHlBle2Ohf9oPIL5L5+9+B3gS+Y9woRhRfMNLFWLf/8=";
    };
  };

  nvim-treesitter-pairs = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-pairs";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "nvim-treesitter-pairs";
      rev = "master";
      sha256 = "Nr8h0yUpJMfRx+VZ3Jf03p3tCeSc7JWiwtruqkjzzkw=";
    };
  };

  blink-ripgrep-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "blink-ripgrep";
    src = pkgs.fetchFromGitHub {
      owner = "mikavilpas";
      repo = "blink-ripgrep.nvim";
      rev = "master";
      sha256 = "ShwwdJ2DkwVEbpduKGNmuA+5ziNaUpFlL8LdGbk+ggE=";
    };
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    dropbar-nvim

    blink-ripgrep-nvim
    latex-nvim
    mysnippets
    nvim-treesitter-pairs
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("dropbar").setup({
        icons = {
          kinds = {
            file_icon = function(path)
              local file_icon = "󰈔 "
              local file_icon_hl = "DropBarIconKindFile"

              local mini_icon, mini_icon_hl = MiniIcons.get("file", vim.fs.basename(path))

              if not mini_icon then
                local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(buf)
                  return vim.api.nvim_buf_get_name(buf) == path
                end)
                if buf then
                  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
                  mini_icon, mini_icon_hl = MiniIcons.get("filetype", filetype)
                end
              end

              file_icon = mini_icon and mini_icon .. " " or file_icon
              file_icon_hl = mini_icon_hl

              return file_icon, file_icon_hl
            end
          }
        }
      })
    '';
}
