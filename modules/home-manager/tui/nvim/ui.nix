{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim.plugins = {
    nui = {
      enable = true;
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "nui.nvim";
        name = "nui";
        version = "0.3.0-1";
        src = inputs.nui-nvim;
      };
    };
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
    rainbow-delimiters.enable = true;
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
    noice = {
      enable = true;
      package = pkgs.vimPlugins.noice-nvim.overrideAttrs {
        dependencies = [];
        nvimSkipModules = [
          "noice.ui.cmdline"
          "noice.util.nui"
          "noice.message.init"
          "noice.view.init"
          "noice.view.backend.notify_send"
          "noice.view.backend.notify"
          "noice.view.backend.snacks"
          "noice.view.backend.mini"
          "noice.view.backend.virtualtext"
          "noice.view.nui"
          "noice.view.scrollbar"
          "noice.text.init"
          "noice.text.block"
        ];
      };
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
        };
        presets = {
          bottom_search = true;
          long_message_to_split = true;
        };
        routes = [
          {
            filter = {
              event = "msg_show";
              any = [{find = "%d+L, %d+B";} {find = "; after #%d+";} {find = "; before #%d+";}];
            };
            view = "mini";
          }
          {
            filter = {
              event = "msg_show";
              any = [{find = "client.supports_method is deprecated";}];
            };
            opts.skip = true;
          }
        ];
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = ["n" "i" "s"];
      key = "<C-f>";
      action.__raw = ''function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end'';
      options.silent = true;
      options.expr = true;
    }
    {
      mode = ["n" "i" "s"];
      key = "<C-b>";
      action.__raw = ''function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end'';
      options.silent = true;
      options.expr = true;
    }
  ];
}
