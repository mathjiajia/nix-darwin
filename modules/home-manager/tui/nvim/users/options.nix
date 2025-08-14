{
  programs.nixvim = {
    globals = {
      loaded_perl_provider = 0;
      loaded_python3_provider = 0;
      loaded_ruby_provider = 0;

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
    };

    clipboard.register = "unnamedplus";

    opts = {
      # 1 important

      # 2 moving around, seaching patterns
      ignorecase = true;
      smartcase = true;

      # 3 tags

      # 4 displaying text
      smoothscroll = true;
      scrolloff = 10;
      linebreak = true;
      breakindent = true;
      showbreak = "> ";
      fillchars = {
        diff = "╱";
        eob = " ";
        fold = " ";
      };
      cmdheight = 0;
      number = true;
      relativenumber = true;

      # 5 syntax, highlighting and spelling
      colorcolumn = "120";
      cursorline = true;
      spelllang = "en_gb";

      # 6 multiple windows
      laststatus = 3;
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;

      # 7 multiple tab pages

      # 8 terminal

      # 9 using the mouse

      # 10 messages and info
      confirm = true;

      # 11 selecting text

      # 12 editing text
      undofile = true;
      undolevels = 200;
      formatoptions = "tcroqnlj";
      pumheight = 10;

      # 13 tabs and indenting
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;

      # 14 folding
      foldmethod = "expr";
      foldlevel = 99;

      # 15 diff mode

      # 16 mapping
      timeoutlen = 300;

      # 17 reading and writng files

      # 18 the swap file
      swapfile = false;
      updatetime = 200;

      # 19 command line editing

      # 20 executing external commands

      # 21 running make and jumping to errors (quickfix)

      # 22 language specific

      # 23 multi-byte characters

      # 24 various
      virtualedit = "block";
      signcolumn = "yes";
      winborder = "rounded";
    };
  };
}
