{
  keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options.expr = true;
      options.silent = true;
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options.expr = true;
      options.silent = true;
    }

    {
      mode = "n";
      key = "gco";
      action = "o<esc>Vcx<esc>:normal gcc<CR>fxa<bs>";
      options.desc = "Create a commented line below";
    }
    {
      mode = "n";
      key = "gcO";
      action = "O<esc>Vcx<esc>:normal gcc<CR>fxa<bs>";
      options.desc = "Create a commented line above";
    }

    {
      mode = "x";
      key = "p";
      action = "p:let @+=@0<CR>";
      options.desc = "Paste w/o overwriting clipboard (unnamedplus)";
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
