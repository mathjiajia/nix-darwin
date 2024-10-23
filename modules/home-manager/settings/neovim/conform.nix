{ pkgs, ... }:
{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    # because combinePlugins.enable = true, the collision of `doc` is
    # unavoidable. this renames them.
    package = pkgs.vimPlugins.conform-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          mv $out/doc/recipes.md $out/doc/conform-nvim_recipes.md
        '';
    });
    settings = {
      formatters = {
        latexindent.prepend_args = [
          "-c"
          "./.aux"
          "-m"
        ];
        bibtex-tidy.prepend_args = [
          "--curly"
          "--tab"
          "--trailing-commas"
          "--sort-fields=author,year,month,day,title,shorttitle"
          "--remove-braces"
        ];
      };
      formatters_by_ft = {
        bib = [ "bibtex-tidy" ];
        c = [ "clang-format" ];
        css = [ "prettierd" ];
        html = [ "prettierd" ];
        javascript = [ "prettierd" ];
        json = [ "prettierd" ];
        jsonc = [ "prettierd" ];
        fish = [ "fish_indent" ];
        markdown = [ "prettierd" ];
        "markdown.mdx" = [ "prettierd" ];
        yaml = [ "prettierd" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        python = [ "black" ];
        sh = [ "shfmt" ];
        swift = [ "swift_format" ];
        tex = [ "latexindent" ];
        toml = [ "taplo" ];
      };
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 2000;
      };
    };
  };
}
