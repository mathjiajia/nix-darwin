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
    ];

    plugins.conform-nvim = {
      enable = true;
      package = pkgs.vimPlugins.conform-nvim.overrideAttrs {
        postInstall =
          # sh
          ''
            mv $out/doc/recipes.md $out/doc/conform-nvim_recipes.md
          '';
      };
      settings = {
        formatters = {
          bibtex-tidy.prepend_args = [
            "--curly"
            "--tab"
            "--trailing-commas"
            "--sort-fields=author,year,month,day,title,shorttitle"
            "--remove-braces"
          ];
          tex-fmt.prepend_args = [
            "--wraplen"
            "120"
            "--tabsize"
            "1"
            "--usetabs"
          ];
        };
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
          swift = ["swift_format"];
          tex = ["tex-fmt"];
        };
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 2000;
        };
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>cF";
        action.__raw =
          # lua
          ''
            function()
            	require("conform").format({ formatters = { "injected" }, timeout_ms = 2000 })
            end
          '';
        options.desc = "Format Injected Langs";
      }
    ];
  };
}
