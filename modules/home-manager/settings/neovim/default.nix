{
  neovim-nightly-overlay,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
  };

  programs.nixvim.extraPackages = with pkgs; [
    luajit
    nodejs # for copilot.lua
    python312Packages.ipython # for REPL (overseer)

    vscode-extensions.vadimcn.vscode-lldb
    # vscode-extensions.ms-vscode.cpptools

    commitlint
    markdownlint-cli2
    shellcheck

    bibtex-tidy
    black
    alejandra
    # nixfmt-rfc-style
    prettierd
    shfmt
    stylua
  ];

  programs.nixvim.globals = {
    loaded_perl_provider = 0;
    loaded_python3_provider = 0;
    loaded_ruby_provider = 0;

    loaded_gzip = 1;
    loaded_matchit = 1;
    loaded_matchparen = 1;
    loaded_netrwPlugin = 1;
    loaded_remote_plugins = 1;
    loaded_shada_plugin = 1;
    loaded_spellfile_plugin = 1;
    loaded_tarPlugin = 1;
    loaded_tutor_mode_plugin = 1;
    loaded_zipPlugin = 1;
  };

  programs.nixvim.clipboard.register = "unnamedplus";
  programs.nixvim.colorschemes.nord = {
    enable = false;
    settings = {
      bold = false;
      borders = true;
      contrast = true;
      cursorline_transparent = true;
      disable_background = false;
      enable_sidebar_background = true;
      italic = true;
      uniform_diff_background = true;
    };
  };

  programs.nixvim.colorschemes.kanagawa = {
    enable = true;
    settings = {
      colors = {theme = {all = {ui = {bg_gutter = "none";};};};};
      compile = true;
      dimInactive = false;
      overrides =
        #lua
        ''
          function(colors)
            return {
              RainbowDelimiterRed = { fg = colors.palette.waveRed },
              RainbowDelimiterYellow = { fg = colors.palette.carpYellow },
              RainbowDelimiterBlue = { fg = colors.palette.dragonBlue },
              RainbowDelimiterOrange = { fg = colors.palette.surimiOrange },
              RainbowDelimiterGreen = { fg = colors.palette.springGreen },
              RainbowDelimiterViolet = { fg = colors.palette.oniViolet },
              RainbowDelimiterCyan = { fg = colors.palette.waveAqua1 },
            }
          end
        '';
      terminalColors = false;
      transparent = false;
      undercurl = true;
    };
  };

  imports = [
    ./performance.nix

    ./options.nix
    ./keymaps.nix
    ./autocmds.nix

    ./diagnostics.nix

    ./conform.nix
    ./compiler.nix
    ./completion.nix
    ./dap.nix
    ./editor.nix
    ./lint.nix
    ./lsp.nix
    ./neo-tree.nix
    ./treesitter.nix
    ./ui.nix

    ./extra-plugins.nix
    # ./nvchad.nix

    ./extra-files.nix
  ];
}
