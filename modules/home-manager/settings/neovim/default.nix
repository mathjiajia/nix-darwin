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

    alejandra
    bibtex-tidy
    black
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
    # enable = true;
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
    # enable = true;
    settings = {
      colors = {theme = {all = {ui = {bg_gutter = "none";};};};};
      compile = true;
      dimInactive = false;
      overrides =
        # lua
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

  programs.nixvim.colorschemes.catppuccin = {
    enable = true;
    settings = {
      # default_integrations = false;
      integrations = {
        aerial = true;
        alpha = false;
        dropbar.enabled = true;
        grug_far = true;
        neogit = false;
        noice = true;
        notify = true;
        nvim_surround = true;
        nvimtree = false;
        ufo = false;
        overseer = true;
        render_markdown = false;
        telescope.enabled = false;
        illuminate.enabled = false;
      };
      custom_highlights =
        # lua
        ''
          function(colors)
            return {
              StatusLineMode = { fg = colors.text, bg = "#404040", bold = true },
            }
          end
        '';
      color_overrides = {
        latte = {
          rosewater = "#c14a4a";
          flamingo = "#c14a4a";
          red = "#c14a4a";
          maroon = "#c14a4a";
          pink = "#945e80";
          mauve = "#945e80";
          peach = "#c35e0a";
          yellow = "#b47109";
          green = "#6c782e";
          teal = "#4c7a5d";
          sky = "#4c7a5d";
          sapphire = "#4c7a5d";
          blue = "#45707a";
          lavender = "#45707a";
          text = "#654735";
          subtext1 = "#73503c";
          subtext0 = "#805942";
          overlay2 = "#8c6249";
          overlay1 = "#8c856d";
          overlay0 = "#a69d81";
          surface2 = "#bfb695";
          surface1 = "#d1c7a3";
          surface0 = "#e3dec3";
          base = "#f9f5d7";
          mantle = "#f0ebce";
          crust = "#e8e3c8";
        };
        mocha = {
          rosewater = "#ea6962";
          flamingo = "#ea6962";
          red = "#ea6962";
          maroon = "#ea6962";
          pink = "#d3869b";
          mauve = "#d3869b";
          peach = "#e78a4e";
          yellow = "#d8a657";
          green = "#a9b665";
          teal = "#89b482";
          sky = "#89b482";
          sapphire = "#89b482";
          blue = "#7daea3";
          lavender = "#7daea3";
          text = "#ebdbb2";
          subtext1 = "#d5c4a1";
          subtext0 = "#bdae93";
          overlay2 = "#a89984";
          overlay1 = "#928374";
          overlay0 = "#595959";
          surface2 = "#4d4d4d";
          surface1 = "#404040";
          surface0 = "#292929";
          base = "#1d2021";
          mantle = "#191b1c";
          crust = "#141617";
        };
      };
      term_colors = true;
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
