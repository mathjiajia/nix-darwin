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
        callback.__raw = ''function() if vim.o.buftype ~= "nofile" then vim.cmd.checktime() end end'';
      }
      {
        event = "TextYankPost";
        desc = "Highlight the Yanked Text";
        group = "HighlightYank";
        callback.__raw = ''function() vim.hl.on_yank() end'';
      }
      {
        event = "BufReadPost";
        desc = "Last Position";
        group = "LastPlace";
        callback.__raw =
          # lua
          ''
            function(args)
              local exclude_bt = { "help", "nofile", "quickfix" }
              local exclude_ft = { "gitcommit" }
              local buf = args.buf
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

      {
        event = "BufReadPost";
        group = "OpenFile";
        pattern = ["*.jpeg" "*.jpg" "*.pdf" "*.png"];
        callback.__raw =
          # lua
          ''
            function(args)
              vim.fn.jobstart("open '" .. vim.fn.expand("%") .. "'", { detach = true })
              vim.api.nvim_buf_delete(args.buf, {})
            end
          '';
      }
    ];
  };
}
