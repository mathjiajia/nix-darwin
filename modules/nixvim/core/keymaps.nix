{
  keymaps = [
    # better up and down
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Move down by screen line (counts use file lines)";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Move up by screen line (counts use file lines)";
        expr = true;
        silent = true;
      };
    }

    {
      mode = "n";
      key = "gco";
      action = "o<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>";
      options.desc = "Create a commented line below";
    }
    {
      mode = "n";
      key = "gcO";
      action = "O<Esc>Vcx<Esc><Cmd>normal gcc<CR>fxa<BS>";
      options.desc = "Create a commented line above";
    }

    {
      mode = "x";
      key = "/";
      action = "<Esc>/\\%V";
      options.desc = "Search within selection";
    }

    {
      mode = "n";
      key = "<leader>qq";
      action.__raw = "vim.diagnostic.setqflist";
      options.desc = "Send all diagnostics to [q]uickfix list";
    }
    {
      mode = "n";
      key = "<leader>ql";
      action.__raw = "vim.diagnostic.setloclist";
      options.desc = "Send buffer diagnostics to [l]ocation list";
    }
  ];
}
