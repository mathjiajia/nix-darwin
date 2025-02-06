{pkgs, ...}: {
  programs.nixvim.plugins.mini = {
    enable = true;
    package = pkgs.vimPlugins.mini-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        oldAttrs.postInstall
        or ""
        + # sh
        ''rm -rf $out/doc/mini-cursorword.txt'';
    });
    modules = {
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
          hex_color.__raw = ''require("mini.hipatterns").gen_highlighter.hex_color()'';
        };
      };
      icons.lsp = {
        "function".glyph = "";
        object.glyph = "";
        value.glyph = "";
      };
    };
  };
}
