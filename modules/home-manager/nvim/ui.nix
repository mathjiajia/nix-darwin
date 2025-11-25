{
  plugins = {
    mini-icons.enable = true;
    mini-statusline.enable = true;
    mini-diff = {
      enable = true;
      settings.view = {
        style = "sign";
        signs = {
          add = "┃";
          change = "┃";
          delete = "-";
        };
      };
    };
    mini-hipatterns = {
      enable = true;
      settings.highlighters = {
        fixme = {
          pattern = "%f[%w]()FIXME()%f[%W]";
          group = "MiniHipatternsFixme";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticError";
          };
        };
        hack = {
          pattern = "%f[%w]()HACK()%f[%W]";
          group = "MiniHipatternsHack";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticWarn";
          };
        };
        todo = {
          pattern = "%f[%w]()TODO()%f[%W]";
          group = "MiniHipatternsTodo";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticInfo";
          };
        };
        note = {
          pattern = "%f[%w]()NOTE()%f[%W]";
          group = "MiniHipatternsNote";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticHint";
          };
        };
      };
    };
    dropbar = {
      enable = true;
      # luaConfig = lib.mkForce "";
      settings = {
        symbol.on_click = false;
        menu = {
          preview = false;
          hover = false;
          scroobar.enable = false;
        };
        icons.kinds.file_icon.__raw = ''
          function(path)
          	local file_icon = "󰈔 "
          	local file_icon_hl = "DropBarIconKindFile"
          	if not _G.MiniIcons then
          		return file_icon, file_icon_hl
          	end

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
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>go";
      action.__raw = "function() MiniDiff.toggle_overlay() end";
      options.desc = "Hunk Diff [O]verlay";
    }
  ];
}
