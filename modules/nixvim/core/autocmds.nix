{
  autoGroups = {
    highlightOnYank = { };
    lastLoc = { };
  };

  autoCmd = [
    {
      event = "TextYankPost";
      group = "highlightOnYank";
      callback.__raw = "function() vim.hl.hl_op() end";
    }

    {
      event = "BufReadPost";
      group = "lastLoc";
      desc = "go to last loc when opening a buffer";
      callback.__raw = ''
        function()
        	local mark = vim.api.nvim_buf_get_mark(0, '"')
        	local lcount = vim.api.nvim_buf_line_count(0)
        	if mark[1] > 0 and mark[1] <= lcount then
        		pcall(vim.api.nvim_win_set_cursor, 0, mark)
        	end
        end
      '';
    }

    {
      event = "LspProgress";
      callback.__raw = ''
        function(ev)
        	local value = ev.data.params.value
        	vim.api.nvim_echo({ { value.message or "done" } }, false, {
        		id = "lsp." .. ev.data.params.token,
        		kind = "progress",
        		source = "vim.lsp",
        		title = value.title,
        		status = value.kind ~= "end" and "running" or "success",
        		percent = value.percentage,
        	})
        end
      '';
    }
  ];
}
