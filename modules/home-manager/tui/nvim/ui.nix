{
  # programs.nixvim.extraPython3Packages = p: [p.pylatexenc];
  programs.nixvim.plugins = {
    render-markdown = {
      enable = true;
      settings = {
        file_types = ["markdown" "codecompanion" "quarto"];
        sign.enabled = false;
        code = {
          position = "right";
          min_width = 80;
          width = "block";
          border = "thin";
        };
        heading = {
          icons = [" 󰼏 " " 󰎨 " " 󰼑 " " 󰎲 " " 󰼓 " " 󰎴 "];
          border = true;
          render_modes = true;
        };
        pipe_table = {
          alignment_indicator = "─";
          border = ["╭" "┬" "╮" "├" "┼" "┤" "╰" "┴" "╯" "│" "─"];
        };
        anti_conceal = {
          disabled_modes = ["n"];
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

    dropbar = {
      enable = true;
      settings = {
        icons.kinds.file_icon.__raw =
          # lua
          ''
            function(path)
              local file_icon = "󰈔 "
              local file_icon_hl = "DropBarIconKindFile"

              local mini_icon, mini_icon_hl = require("mini.icons").get("file", vim.fs.basename(path))

              if not mini_icon then
                local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(buf)
                  return vim.api.nvim_buf_get_name(buf) == path
                end)
                if buf then
                  local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
                  mini_icon, mini_icon_hl = require("mini.icons").get("filetype", filetype)
                end
              end

              file_icon = mini_icon and mini_icon .. " " or file_icon
              file_icon_hl = mini_icon_hl
              return file_icon, file_icon_hl
            end
          '';
        sources.path.modified.__raw =
          # lua
          ''
            function(sym)
            	return sym:merge({
            		name = sym.name .. "[+]",
            		name_hl = "DiffAdded",
            	})
            end
          '';
      };
    };
  };
}
