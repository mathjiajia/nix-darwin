{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    # linters
    commitlint
    shellcheck
  ];

  plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        bash = [ "shellcheck" ];
        gitcommit = [ "commitlint" ];
        # zsh = [ "zsh" ];
      };
    };

    conform-nvim = {
      enable = true;
      package = pkgs.vimPlugins.conform-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          oldAttrs.postInstall or ""
          # sh
          + ''mv $out/doc/{recipes.md,conform-nvim_recipes.md}'';
      });
      autoInstall.enable = true;
      settings = {
        formatters.bibtex-tidy.prepend_args = [
          "--curly"
          "--tab"
          "--trailing-commas"
          "--sort-fields=author,year,month,day,title,shorttitle"
          "--remove-braces"
        ];
        formatters_by_ft = {
          bib = [ "bibtex-tidy" ];
          css = [ "prettier" ];
          html = [ "prettier" ];
          javascript = [ "prettier" ];
          markdown = [ "prettier" ];
          yaml = [ "prettier" ];
          json = [ "jq" ];
          jsonnet = [ "jsonnetfmt" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          python = [
            "ruff_fix"
            "ruff_format"
            "ruff_organize_imports"
          ];
          sh = [ "shfmt" ];
        };
        format_on_save.__raw = ''
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
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cF";
      action.__raw = "function() require('conform').format({ formatters = { 'injected' }, timeout_ms = 2000 }) end";
      options.desc = "[F]ormat Injected Langs";
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
}
