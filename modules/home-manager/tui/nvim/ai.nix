{
  programs.nixvim.plugins.sidekick.enable = true;

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action.__raw = ''function() if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end end'';
      options.expr = true;
      options.desc = "Sidekick Toggle CLI";
    }
    {
      mode = "n";
      key = "<leader>aa";
      action.__raw = ''function() require("sidekick.cli").toggle() end'';
      options.desc = "Sidekick Toggle CLI";
    }
    {
      mode = "n";
      key = "<leader>as";
      action.__raw = ''function() require("sidekick.cli").select({ filter = { installed = true } }) end'';
      options.desc = "Sidekick Select CLI";
    }
    {
      mode = ["x" "n"];
      key = "<leader>at";
      action.__raw = ''function() require("sidekick.cli").send({ msg = "{this}" }) end'';
      options.desc = "Send This";
    }
    {
      mode = "x";
      key = "<leader>av";
      action.__raw = ''function() require("sidekick.cli").send({ msg = "{selection}" }) end'';
      options.desc = "Send Visual Selection";
    }
    {
      mode = ["n" "x"];
      key = "<leader>ap";
      action.__raw = ''function() require("sidekick.cli").select_prompt() end'';
      options.desc = "Sidekick Prompt Picker";
    }
    {
      mode = ["n" "x" "i" "t"];
      key = "<C-.>";
      action.__raw = ''function() require("sidekick.cli").focus() end'';
      options.desc = "Sidekick Switch Focus";
    }
  ];
}
