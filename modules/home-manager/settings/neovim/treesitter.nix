{ ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      auto_install = false;
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
      indent.enable = true;
      highlight = {
        enable = true;
      };
    };
  };
}