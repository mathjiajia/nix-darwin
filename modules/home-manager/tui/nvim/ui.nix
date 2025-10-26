{ inputs, pkgs, ... }:
let
  slimline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "slimline";
    src = inputs.slimline-nvim;
    nvimSkipModules = [
      "slimline.components.diagnostics"
      "slimline.components.filetype_lsp"
      "slimline.components.mode"
      "slimline.components.path"
      "slimline.components.progress"
      "slimline.components.recording"
      "slimline.components.searchcount"
      "slimline.components.selectioncount"
    ];
  };
in
{
  programs.nixvim.extraPlugins = [
    slimline-nvim
    # pkgs.vimPlugins.mini-diff
    pkgs.vimPlugins.mini-hipatterns
  ];

  programs.nixvim.plugins.mini-icons.enable = true;

  # programs.nixvim.keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>hp";
  #     action.__raw = ''function() MiniDiff.toggle_overlay() end'';
  #     options.desc = "Hunk Diff Overlay";
  #   }
  # ];

  programs.nixvim.extraConfigLua = ''
    require("slimline").setup({
    	style = "fg",
    	components = { center = { "searchcount" } },
    	configs = { git = { hl = { primary = "Function" } } },
    })

    -- require("mini.diff").setup({
    --   view = {
    --     style = "sign",
    --     signs = { add = "┃", change = "┃", delete = "_" },
    --   },
    -- })

    require("mini.hipatterns").setup({
    	highlighters = {
    		fixme = {
    			pattern = "%f[%w]()FIXME()%f[%W]",
    			group = "MiniHipatternsFixme",
    			extmark_opts = { sign_text = "", sign_hl_group = "DiagnosticError" },
    		},
    		hack = {
    			pattern = "%f[%w]()HACK()%f[%W]",
    			group = "MiniHipatternsHack",
    			extmark_opts = { sign_text = "", sign_hl_group = "DiagnosticWarn" },
    		},
    		todo = {
    			pattern = "%f[%w]()TODO()%f[%W]",
    			group = "MiniHipatternsTodo",
    			extmark_opts = { sign_text = "", sign_hl_group = "DiagnosticInfo" },
    		},
    		note = {
    			pattern = "%f[%w]()NOTE()%f[%W]",
    			group = "MiniHipatternsNote",
    			extmark_opts = { sign_text = "", sign_hl_group = "DiagnosticHint" },
    		},
    	},
    })
  '';
}
