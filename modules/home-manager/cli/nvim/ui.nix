{
  programs.nixvim.plugins = {
    markview = {
      enable = true;
      settings = {
        # preview = {
        filetypes = ["markdown" "quarto" "rmd" "codecompanion"];
        # ignore_buftypes.__raw = "{}";
        buf_ignore.__raw = "{}";
        # icon_provider = "mini";
        # };
      };
    };
    rainbow-delimiters.enable = true;
    dropbar = {
      enable = true;
      settings.icons.kinds.file_icon.__raw =
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
    };
    noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
        routes = [
          {
            filter = {
              event = "msg_show";
              any = [{find = "%d+L, %d+B";} {find = "; after #%d+";} {find = "; before #%d+";}];
            };
            view = "mini";
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
