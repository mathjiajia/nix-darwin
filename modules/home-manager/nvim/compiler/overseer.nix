{ pkgs, ... }:
{
  plugins.overseer = {
    enable = true;
    # w/o calling setup causes dap integration bug
    package = pkgs.vimPlugins.overseer-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        # sh
        + ''mv $out/doc/{recipes.md,overseer-nvim_recipes.md}'';
    });
  };

  extraFiles."lua/overseer/template/user".source = ./user;

  keymaps = [
    {
      mode = "n";
      key = "<leader>or";
      action = "<Cmd>OverseerRun<CR>";
      options.desc = "[O]verseer [R]un";
    }
    {
      mode = "n";
      key = "<leader>os";
      action = "<Cmd>OverseerShell<CR>";
      options.desc = "[O]verseer [S]hell";
    }
    {
      mode = "n";
      key = "<leader>oo";
      action = "<Cmd>OverseerToggle!<CR>";
      options.desc = "[O]verseer [O]pen";
    }
  ];
}
