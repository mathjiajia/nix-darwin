{
  programs.nixvim = {
    autoGroups = {
      CheckTime = {};
      HighlightYank = {};
      LastPlace = {};
      OpenFile = {};
    };

    autoCmd = [
      {
        event = ["FocusGained" "TermClose" "TermLeave"];
        group = "CheckTime";
        callback.__raw =
          # lua
          ''function() if vim.o.buftype ~= "nofile" then vim.cmd.checktime() end end'';
      }
      {
        event = ["TextYankPost"];
        desc = "Highlight the Yanked Text";
        group = "HighlightYank";
        callback.__raw =
          # lua
          "function() vim.highlight.on_yank() end";
      }
      {
        event = ["BufReadPost"];
        desc = "Last Position";
        group = "LastPlace";
        callback.__raw =
          # lua
          ''
            function(event)
              local exclude_bt = { "help", "nofile", "quickfix" }
              local exclude_ft = { "gitcommit" }
              local buf = event.buf
              if
                vim.list_contains(exclude_bt, vim.bo[buf].buftype)
                or vim.list_contains(exclude_ft, vim.bo[buf].filetype)
                or vim.api.nvim_win_get_cursor(0)[1] > 1
                or vim.b[buf].last_pos
              then
                return
              end
              vim.b[buf].last_pos = true
              local mark = vim.api.nvim_buf_get_mark(buf, '"')
              local lcount = vim.api.nvim_buf_line_count(buf)
              if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
              end
            end
          '';
      }
      # {
      #   event = [ "FileType" ];
      #   desc = "Enable Treesitter";
      #   callback.__raw =
      #     # lua
      #     ''
      #       function(ev)
      #         if not pcall(vim.treesitter.start, ev.buf) then
      #           return
      #         end
      #         vim.opt_local.foldmethod = "expr"
      #         vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      #         vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      #       end
      #     '';
      # }
      {
        event = ["BufReadPost"];
        group = "OpenFile";
        pattern = ["*.jpeg" "*.jpg" "*.pdf" "*.png"];
        callback.__raw =
          # lua
          ''
            function(ev)
              vim.fn.jobstart("open '" .. vim.fn.expand("%") .. "'", { detach = true })
              vim.api.nvim_buf_delete(ev.buf, {})
            end
          '';
      }
      {
        event = ["BufWritePost"];
        pattern = ["*/spell/*.add"];
        callback.__raw =
          # lua
          ''function() vim.cmd.mkspell({ "%", bang = true, mods = { silent = true } }) end'';
      }
    ];
  };
}
