{
  inputs,
  pkgs,
  ...
}: let
  fff-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "fff";
    src = inputs.fff-nvim;
    nvimSkipModules = [
      "fff"
      "fff.fuzzy"
      "fff.main"
      "fff.picker_ui"
      "fff.rust.init"
      "fff.git_utils"
      "fff.utils"
      "fff.file_picker.init"
      "fff.file_picker.preview"
      "fff.file_picker.icons"
      "fff.file_picker.image"
    ];
    patches = [./fix-fff-nvim.patch];
  };
  math-conceal-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "math-conceal";
    src = inputs.math-conceal-nvim;
    patches = [./fix-math-conceal.patch];
  };
  nvim-math-snippets = pkgs.vimUtils.buildVimPlugin {
    name = "math-snippets";
    src = inputs.nvim-math-snippets;
    nvimSkipModules = [
      "math-snippets.position"
      "math-snippets.context"
      "math-snippets.latex"
    ];
  };
  slimline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "slimline";
    src = inputs.slimline-nvim;
    nvimSkipModules = [
      "slimline.components.progress"
      "slimline.components.mode"
      "slimline.components.selectioncount"
      "slimline.components.recording"
      "slimline.components.path"
      "slimline.components.filetype_lsp"
      "slimline.components.diagnostics"
      "slimline.components.searchcount"
    ];
  };
in {
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    blink-pairs

    fff-nvim
    math-conceal-nvim
    nvim-math-snippets
    slimline-nvim
  ];

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = ''function() require("fff").find_files() end'';
      options.desc = "Open File Picker";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = ''function() require("fff").find_in_git_root() end'';
      options.desc = "Find Git Files";
    }
  ];

  programs.nixvim.extraConfigLua =
    # lua
    ''
      require("vim._extui").enable({ msg = { target = "msg" } })
      require("fff").setup()
      require("math-conceal").setup()
      require("blink.pairs").setup({
       mappings = {
      	 pairs = {
      		 ["'"] = {
      			 {
      				 "\'\'\'",
      				 "\'\'\'",
      				 when = function()
      					 local cursor = vim.api.nvim_win_get_cursor(0)
      					 local line = vim.api.nvim_get_current_line()
      					 return line:sub(cursor[2] - 1, cursor[2]) == "\'\'"
      				 end,
      				 filetypes = { "python" },
      			 },
      			 {
      				 "'",
      				 enter = false,
      				 space = false,
      				 when = function()
      					 local cursor = vim.api.nvim_win_get_cursor(0)
      					 local char = vim.api.nvim_get_current_line():sub(cursor[2], cursor[2])
      					 return not char:match("%w")
      						 and (vim.bo.filetype ~= "rust" or char:match("[&<]"))
      						 and not vim.list_contains({ "bib", "tex", "plaintex" }, vim.bo.filetype)
      				 end,
      			 },
      		 },
      		 ["`"] = {
      			 {
      				 "```",
      				 "```",
      				 when = function()
      					 local cursor = vim.api.nvim_win_get_cursor(0)
      					 local line = vim.api.nvim_get_current_line()
      					 return line:sub(cursor[2] - 1, cursor[2]) == "``"
      				 end,
      				 filetypes = { "markdown", "vimwiki", "rmarkdown", "rmd", "pandoc", "quarto", "typst" },
      			 },
      			 { "`", "'", filetypes = { "bib", "latex", "tex" } },
      			 { "`", enter = false, space = false },
      		 },
      	 },
       },
       highlights = {
      	 groups = {
      		 "BlinkPairsBlue",
      		 "BlinkPairsYellow",
      		 "BlinkPairsGreen",
      		 "BlinkPairsTeal",
      		 "BlinkPairsMagenta",
      		 "BlinkPairsPurple",
      		 "BlinkPairsOrange",
      	 },
       },
      })

      local function fold_virt_text(result, start_text, lnum)
       local text = ""
       local hl
       for i = 1, #start_text do
      	 local char = start_text:sub(i, i)
      	 local captured_highlights = vim.treesitter.get_captures_at_pos(0, lnum, i - 1)
      	 local outmost_highlight = captured_highlights[#captured_highlights]
      	 if outmost_highlight then
      		 local new_hl = "@" .. outmost_highlight.capture
      		 if new_hl ~= hl then
      			 table.insert(result, { text, hl })
      			 text = ""
      			 hl = nil
      		 end
      		 text = text .. char
      		 hl = new_hl
      	 else
      		 text = text .. char
      	 end
       end
       table.insert(result, { text, hl })
      end
      function _G.custom_foldtext()
       local start_text = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
       local nline = vim.v.foldend - vim.v.foldstart
       local result = {}
       fold_virt_text(result, start_text, vim.v.foldstart - 1)
       table.insert(result, { "    ", nil })
       table.insert(result, { " ↙ " .. nline .. " lines ", "Search" })
       return result
      end

      require("slimline").setup({
       style = "bg",
       configs = {
      	 path = { hl = { primary = "Define" } },
      	 git = { hl = { primary = "Function" } },
      	 filetype_lsp = { hl = { primary = "String" } },
       }
      })
    '';
}
