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
      key = "<leader>bd";
      mode = ["n"];
      action.__raw =
        # lua
        ''
          function()
          	vim.api.nvim_buf_delete(0, {})
          end
        '';
      options.desc = "Delete Buffer";
    }
    {
      key = "<leader>bD";
      mode = ["n"];
      action.__raw =
        # lua
        ''
          function()
          	vim.api.nvim_buf_delete(0, { force = true })
          end
        '';
      options.desc = "Delete Buffer (force)";
    }
  ];
}
