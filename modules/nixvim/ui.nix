{
  plugins = {
    dropbar = {
      enable = true;
      callSetup = false;
    };

    mini-icons = {
      enable = true;
      mockDevIcons = true;
    };
    mini-statusline.enable = true;
    mini-diff = {
      enable = true;
      settings.view = {
        style = "sign";
        signs = {
          add = "┃";
          change = "┃";
          delete = "-";
        };
      };
    };
    mini-hipatterns = {
      enable = true;
      settings.highlighters = {
        fixme = {
          pattern = "%f[%w]()FIXME()%f[%W]";
          group = "MiniHipatternsFixme";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticError";
          };
        };
        hack = {
          pattern = "%f[%w]()HACK()%f[%W]";
          group = "MiniHipatternsHack";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticWarn";
          };
        };
        todo = {
          pattern = "%f[%w]()TODO()%f[%W]";
          group = "MiniHipatternsTodo";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticInfo";
          };
        };
        note = {
          pattern = "%f[%w]()NOTE()%f[%W]";
          group = "MiniHipatternsNote";
          extmark_opts = {
            sign_text = "";
            sign_hl_group = "DiagnosticHint";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>go";
      action.__raw = "function() MiniDiff.toggle_overlay() end";
      options.desc = "Hunk Diff [O]verlay";
    }
  ];
}
