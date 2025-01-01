{pkgs, ...}: {
  programs.nixvim.plugins.lsp = {
    enable = true;
    capabilities =
      # lua
      ''
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      '';
    inlayHints = true;
    keymaps.lspBuf = {
      gD = "declaration";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
      "<C-k>" = "signature_help";
    };
    servers = {
      basedpyright.enable = true;
      clangd.enable = true;
      lua_ls = {
        enable = true;
        settings = {
          completion.callSnippet = "Replace";
          hint.enable = true;
          telemetry.enable = false;
          workspace.checkThirdParty = false;
        };
      };
      matlab_ls = {
        enable = true;
        settings.MATLAB = {
          indexWorkspace = true;
          installPath = "/Applications/MATLAB_R2024b.app";
          telemetry = false;
        };
      };
      nil_ls.enable = true;
      sourcekit = {
        enable = true;
        package = null;
        filetypes = ["swift" "objc" "objcpp"];
      };
      taplo.enable = true;
      texlab = {
        enable = true;
        settings.texlab = {
          build = {
            args = ["-interaction=nonstopmode" "-synctex=1" "%f"];
            forwardSearchAfter = false;
            onSave = true;
          };
          diagnostics.ignoredPatterns = ["^Overfull" "^Underfull"];
          forwardSearch = {
            executable = "/Applications/sioyek.app/Contents/MacOS/sioyek";
            # "${pkgs.sioyek}/Applications/sioyek.app"
            args = [
              "--reuse-window"
              "--execute-command"
              "turn_on_synctex"
              "--inverse-search"
              "${pkgs.texlab}/bin/texlab inverse-search --input %%1 --line %%2"
              "--forward-search-file"
              "%f"
              "--forward-search-line"
              "%l"
              "%p"
            ];
          };
        };
      };
    };
  };
}
