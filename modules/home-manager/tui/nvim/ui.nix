{
  programs.nixvim.plugins = {
    rainbow-delimiters.enable = true;

    render-markdown = {
      enable = true;
      settings = {
        code.width = "block";
        latex.enabled = false;
        pipe_table.preset = "round";
        win_options.colorcolumn = {
          default = "120";
          rendered = "";
        };
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
