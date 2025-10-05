{
  inputs,
  pkgs,
  ...
}: let
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
in {
  programs.nixvim.extraPlugins = [
    slimline-nvim
    pkgs.vimPlugins.mini-hipatterns
  ];

  programs.nixvim.plugins = {
    mini-icons.enable = true;
    dropbar = {
      enable = true;
      settings.icons.kinds.file_icon.__raw = ''
        function(path)
          local file_icon = "󰈔 "
          local file_icon_hl = "DropBarIconKindFile"

          local mini_icon, mini_icon_hl = require("mini.icons").get("file", vim.fs.basename(path))

          if not mini_icon then
            local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(buf)
              return vim.api.nvim_buf_get_name(buf) == path
            end)
            if buf then
              local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
              mini_icon, mini_icon_hl = require("mini.icons").get("filetype", filetype)
            end
          end

          file_icon = mini_icon and mini_icon .. " " or file_icon
          file_icon_hl = mini_icon_hl
          return file_icon, file_icon_hl
        end
      '';
    };
  };

  programs.nixvim.extraConfigLua = ''
    require("slimline").setup({
    	components = { center = { "searchcount", "selectioncount" } },
    	configs = {
    		mode = {
    			format = {
    				["n"] = { short = "NOR" },
    				["v"] = { short = "VIS" },
    				["V"] = { short = "V-L" },
    				["\22"] = { short = "V-B" },
    				["s"] = { short = "SEL" },
    				["S"] = { short = "S-L" },
    				["\19"] = { short = "S-B" },
    				["i"] = { short = "INS" },
    				["R"] = { short = "REP" },
    				["c"] = { short = "CMD" },
    				["r"] = { short = "PRO" },
    				["!"] = { short = "SHE" },
    				["t"] = { short = "TER" },
    				["U"] = { short = "UNK" },
    			},
    		},
    		git = { hl = { primary = "Function" } },
    		progress = { column = true },
    	},
    })

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
