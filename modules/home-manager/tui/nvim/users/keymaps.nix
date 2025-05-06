{
  programs.nixvim.keymaps = [
    {
      mode = ["n" "x"];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options.expr = true;
      options.silent = true;
    }
    {
      mode = ["n" "x"];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options.expr = true;
      options.silent = true;
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
      action.__raw = ''function() vim.diagnostic.setqflist() end'';
      options.desc = "Set Quickfix";
    }
    {
      mode = "n";
      key = "<leader>ql";
      action.__raw = ''function() vim.diagnostic.setloclist() end'';
      options.desc = "Set Loclist";
    }
  ];
}
