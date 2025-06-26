{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      alejandra
      bibtex-tidy
      black
      prettierd
      shfmt
      stylua
      tex-fmt
      # typstyle

      commitlint
      markdownlint-cli2
      shellcheck
    ];

    plugins = {
      lint = {
        enable = true;
        lintersByFt = {
          bash = ["shellcheck"];
          fish = ["fish"];
          gitcommit = ["commitlint"];
          markdown = ["markdownlint-cli2"];
          zsh = ["shellcheck"];
        };
      };

      conform-nvim = {
        enable = true;
        package = pkgs.vimPlugins.conform-nvim.overrideAttrs (oldAttrs: {
          postInstall =
            oldAttrs.postInstall
            or ""
            + # sh
            ''mv $out/doc/recipes.md $out/doc/conform-nvim_recipes.md'';
        });
        settings = {
          formatters.bibtex-tidy.prepend_args = [
            "--curly"
            "--tab"
            "--trailing-commas"
            "--sort-fields=author,year,month,day,title,shorttitle"
            "--remove-braces"
          ];
          formatters_by_ft = {
            bib = ["bibtex-tidy"];
            css = ["prettierd"];
            html = ["prettierd"];
            javascript = ["prettierd"];
            json = ["prettierd"];
            jsonc = ["prettierd"];
            fish = ["fish_indent"];
            markdown = ["prettierd"];
            "markdown.mdx" = ["prettierd"];
            yaml = ["prettierd"];
            lua = ["stylua"];
            nix = ["alejandra"];
            python = ["black"];
            sh = ["shfmt"];
            tex = ["tex-fmt"];
            # typst = ["typstyle"];
          };
          format_on_save.__raw =
            # lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
              end
            '';
        };
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>cF";
        action.__raw = ''function() require("conform").format({ formatters = { "injected" }, timeout_ms = 2000 }) end'';
        options.desc = "Format Injected Langs";
      }
    ];

    userCommands = {
      FormatDisable = {
        bang = true;
        desc = "Disable autoformat-on-save";
        command.__raw = ''
          function(args)
          	if args.bang then
          		-- FormatDisable! will disable formatting just for this buffer
          		vim.b.disable_autoformat = true
          	else
          		vim.g.disable_autoformat = true
          	end
          end
        '';
      };
      FormatEnable = {
        desc = "Re-enable autoformat-on-save";
        command.__raw = ''
          function()
          	vim.b.disable_autoformat = false
          	vim.g.disable_autoformat = false
          end
        '';
      };
    };
  };
}
