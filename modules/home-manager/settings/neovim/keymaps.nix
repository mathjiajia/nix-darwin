{ ... }:
{
  # TODO: make a keybind `<leader>a` that check if there is a code action available for the cursor position, and opens a panel to select a handler
  # if not then check if there is a mispell and suggest `z=`
  # if not then go to next code action or mispell, whichever is closest.
  programs.nixvim.keymaps =
    let
      mode = [
        "n"
        "x"
      ];
      cmd = verb: "<cmd>${verb}<cr>";
      leader = keys: "<leader>${keys}";
      ctrl = key: "<c-${key}>";
    in

    [
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
        key = "<leader>bd";
        mode = [ "n" ];
        action.__raw = ''
          function()
            vim.api.nvim_buf_delete(0, {})
          end
        '';
        options.desc = "Delete Buffer";
      }
      {
        key = "<leader>bD";
        mode = [ "n" ];
        action.__raw = ''
          function()
            vim.api.nvim_buf_delete(0, { force = true })
          end
        '';
        options.desc = "Delete Buffer (force)";
      }
    ];
}
