{ pkgs, ... }: {
  plugins = {
    dropbar = {
      enable = true;
      callSetup = false;
      package = pkgs.vimPlugins.dropbar-nvim.overrideAttrs (oldAttrs: {
        postPatch =
          (oldAttrs.postPatch or "")
          # sh
          + ''
            substituteInPlace lua/dropbar/configs.lua \
              --replace-fail 'file_icon = function(path)' \
              'file_icon = function(path)
                    if _G.MiniIcons then
                      local icon, hl = MiniIcons.get("file", path)
                      return icon .. " ", hl
                    end' \
              --replace-fail 'dir_icon = function(_)' \
              'dir_icon = function(path)
                    if _G.MiniIcons then
                      local icon, hl = MiniIcons.get("directory", path)
                      return icon .. " ", hl
                    end'
          '';
      });
    };

    mini-icons.enable = true;
    mini-statusline = {
      enable = true;
      package = pkgs.vimPlugins.mini-statusline.overrideAttrs (oldAttrs: {
        postPatch =
          (oldAttrs.postPatch or "")
          # sh
          + ''
            substituteInPlace lua/mini/statusline.lua \
              --replace-fail "name = 'ERROR', sign = 'E'" "name = 'ERROR', sign = ' '" \
              --replace-fail "name = 'HINT', sign = 'H'" "name = 'HINT', sign = ' '" \
              --replace-fail "name = 'INFO', sign = 'I'" "name = 'INFO', sign = ' '" \
              --replace-fail "name = 'WARN', sign = 'W'" "name = 'WARN', sign = ' '"
          '';
      });
    };
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
