{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    capabilities = "require('cmp_nvim_lsp').default_capabilities()";
    inlayHints = true;
    onAttach = # lua
      ''
        local methods = vim.lsp.protocol.Methods
        if client.supports_method(methods.textDocument_documentHighlight) then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
      '';
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
        settings = {
          MATLAB = {
            indexWorkspace = true;
            installPath = "/Applications/MATLAB_R2024b.app";
            telemetry = false;
          };
        };
      };
      nil_ls.enable = true;
      sourcekit = {
        enable = true;
        package = null;
        filetypes = [
          "swift"
          "objc"
          "objcpp"
        ];
      };
      taplo.enable = true;
      texlab = {
        enable = true;
        settings = {
          texlab = {
            build = {
              args = [
                "-interaction=nonstopmode"
                "-synctex=1"
                "%f"
              ];
              forwardSearchAfter = false;
              onSave = true;
            };
            forwardSearch = {
              executable = "/Applications/sioyek.app/Contents/MacOS/sioyek";
              args = [
                "--reuse-window"
                "--execute-command"
                "turn_on_synctex"
                "--inverse-search"
                "texlab inverse-search --input %%1 --line %%2"
                "--forward-search-file"
                "%f"
                "--forward-search-line"
                "%l"
                "%p"
              ];
            };
            diagnostics.ignoredPatterns = [
              "^Overfull"
              "^Underfull"
            ];
          };
        };
      };
    };
  };
}
