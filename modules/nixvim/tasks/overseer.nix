{ pkgs, ... }: {
  plugins.overseer = {
    enable = true;
    package = pkgs.vimPlugins.overseer-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        # sh
        + "mv $out/doc/{recipes.md,overseer-nvim_recipes.md}";
    });
  };

  extraFiles."lua/overseer/template/user".source = ./templates;

  keymaps = [
    {
      mode = "n";
      key = "<leader>rt";
      action = "<Cmd>OverseerRun<CR>";
      options.desc = "[R]un a [t]ask";
    }
    {
      mode = "n";
      key = "<leader>rs";
      action = "<Cmd>OverseerShell<CR>";
      options.desc = "[R]un a [s]hell command";
    }
    {
      mode = "n";
      key = "<leader>rl";
      action = "<Cmd>OverseerToggle!<CR>";
      options.desc = "Toggle task [l]ist";
    }
  ];
}
