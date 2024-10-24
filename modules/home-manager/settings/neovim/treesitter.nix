{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages =
        [
        ];
      settings = {
        ensure_installed = [
          "bash"
          "bibtex"
          "c"
          "comment"
          "commonlisp"
          "csv"
          "editorconfig"
          "diff"
          "glsl"
          "fish"
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "html"
          "json"
          "jsonc"
          "latex"
          "lua"
          "luadoc"
          "luap"
          "markdown"
          "markdown_inline"
          "matlab"
          "nix"
          "python"
          "r"
          "requirements"
          "query"
          "regex"
          "swift"
          "todotxt"
          "toml"
          "typst"
          "vim"
          "vimdoc"
          "yaml"
        ];
        highlight.enable = true;
        indent.enable = true;
      };
    };

    treesitter-context.enable = true;
  };
}
