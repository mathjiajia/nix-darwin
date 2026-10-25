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
        expr = true;
        silent = true;
      };
    }

    {
      mode = "n";
      key = "gco";
      action = "o<Esc>Vcx<Esc>:normal gcc<CR>fxa<BS>";
      options.desc = "Create a commented line below";
    }

    {
      mode = "x";
      key = "/";
      action = "<Esc>/\\%V";
      options.desc = "search within visual selection";
    }

    {
      mode = "n";
      key = "<leader>qq";
      action.__raw = "vim.diagnostic.setqflist";
      options.desc = "Set [Q]uickfix";
    }
    {
      mode = "n";
      key = "<leader>ql";
      action.__raw = "vim.diagnostic.setloclist";
      options.desc = "Set [L]oclist";
    }
  ];
}
