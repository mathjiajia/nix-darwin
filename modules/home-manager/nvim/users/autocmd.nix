{
  autoGroups = {
    checkTime = { };
    highlightYank = { };
    lastPlace = { };
    # lspStatusBar = { };
    openFile = { };
  };

  autoCmd = [
    {
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      group = "checkTime";
      desc = "Check if file changed outside of Neovim";
      callback.__raw = "function() if vim.o.buftype ~= 'nofile' then vim.cmd.checktime() end end";
    }
    {
      event = "TextYankPost";
      group = "highlightYank";
      desc = "Highlight the Yanked Text";
      callback.__raw = "function() vim.hl.on_yank() end";
    }
    {
      event = "BufReadPost";
      group = "lastPlace";
      desc = "go to last loc when opening a buffer";
      callback.__raw = ''
        function(ev)
        	local exclude_bt = { "help", "nofile", "quickfix" }
        	local exclude_ft = { "gitcommit" }
        	local buf = ev.buf
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

    # 0.12
    # {
    #   event = "LspProgress";
    #   desc = "Show LSP progress in TUI";
    #   group = "lspStatusBar";
    #   callback.__raw = ''
    #     function(ev)
    #     	local value = ev.data.params.value
    #     	if value.kind == "begin" then
    #     		vim.api.nvim_ui_send("\027]9;4;1;0\027\\")
    #     	elseif value.kind == "end" then
    #     		vim.api.nvim_ui_send("\027]9;4;0\027\\")
    #     	elseif value.kind == "report" then
    #     		vim.api.nvim_ui_send(string.format("\027]9;4;1;%d\027\\", value.percentage or 0))
    #     	end
    #     end
    #   '';
    # }

    {
      event = "BufReadPost";
      group = "openFile";
      pattern = [
        "*.jpeg"
        "*.jpg"
        "*.mp4"
        "*.pdf"
        "*.png"
      ];
      callback.__raw = ''
        function(ev)
          vim.system({ "open", vim.fn.expand("%") }, { detach = true })
          vim.api.nvim_buf_delete(ev.buf, {})
        end
      '';
    }
  ];
}
