{pkgs, ...}: {
  programs.nixvim.plugins.mini = {
    enable = true;
    package = pkgs.vimPlugins.mini-nvim.overrideAttrs {
      postInstall =
        # sh
        ''
          rm -rf $out/doc/mini-cursorword.txt
        '';
    };
    mockDevIcons = true;
    modules = {
      # diff.view.style = "sign";
      # git = {};
      hipatterns = {
        highlighters = {
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
          hex_color.__raw =
            # lua
            ''
              require("mini.hipatterns").gen_highlighter.hex_color()
            '';
        };
      };
      icons.lsp.copilot = {
        glyph = "";
        hl = "MiniIconsCyan";
      };
      pairs = {};
      statusline = {};
    };
  };
}
