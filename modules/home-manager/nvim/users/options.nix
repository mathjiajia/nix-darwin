{
  globals = {
    loaded_gzip = 1;
    loaded_matchit = 1;
    loaded_matchparen = 1;
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
    loaded_remote_plugins = 1;
    loaded_shada_plugin = 1;
    loaded_spellfile_plugin = 1;
    loaded_tarPlugin = 1;
    loaded_tutor_mode_plugin = 1;
    loaded_zip = 1;
    loaded_zipPlugin = 1;

    mapleader = " ";
  };

  clipboard.register = "unnamedplus";

  opts = {
    linebreak = true;
    pumborder = "rounded";
    winborder = "rounded";
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;

    # Make line numbers default
    relativenumber = true;
    number = true;
    signcolumn = "yes";

    # only one statusline
    laststatus = 3;
    cmdheight = 0;

    # Don't show the mode, since it's already in the status line
    showmode = false;

    # Enable break indent
    breakindent = true;

    # Save undo history
    undofile = true;

    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;

    # Decrease update time
    updatetime = 250;

    # Decrease mapped sequence wait time
    # timeout = false;
    timeoutlen = 300;

    # Configure how new splits should be opened
    splitbelow = true;
    splitright = true;

    # Sets how neovim will display certain whitespace characters in the editor.
    list = true;
    listchars = {
      tab = "▸ ";
      trail = "·";
      nbsp = "␣";
    };

    # Preview substitutions live, as you type!
    inccommand = "split";

    # Show which line your cursor is on
    # cursorline = true;
    # cursorlineopt = "number";

    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 999;

    # folding
    foldlevel = 99;
    foldlevelstart = 99;
    foldmethod = "expr";
    foldexpr = "v:lua.vim.treesitter.foldexpr()";
    fillchars = {
      eob = " ";
      fold = " ";
      foldopen = "";
      foldsep = " ";
      foldclose = "";
    };
  };
}
