{ inputs, pkgs, ... }:
let
  slimline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "slimline";
    src = inputs.slimline-nvim;
    nvimSkipModules = [
      "slimline.components.diagnostics"
      "slimline.components.filetype_lsp"
      "slimline.components.mode"
      "slimline.components.path"
      "slimline.components.progress"
      "slimline.components.recording"
      "slimline.components.searchcount"
      "slimline.components.selectioncount"
    ];
  };
in
{
  programs.nixvim.extraPlugins = [ slimline-nvim ];

  programs.nixvim.plugins = {
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
    mini-icons.enable = true;
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

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>hp";
      action.__raw = ''function() MiniDiff.toggle_overlay() end'';
      options.desc = "Hunk Diff Overlay";
    }
  ];

  programs.nixvim.extraConfigLua = ''
    require("slimline").setup({
    	style = "fg",
    	components = { center = { "searchcount" } },
    	configs = { git = { hl = { primary = "Function" } } },
    })
  '';
}
