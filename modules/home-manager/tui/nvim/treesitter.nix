{pkgs, ...}: {
  programs.nixvim.dependencies.tree-sitter.enable = true;
  programs.nixvim.plugins = {
    treesitter-context.enable = true;
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        bibtex
        c
        commonlisp
        cpp
        css
        csv
        diff
        fish
        git_config
        git_rebase
        gitattributes
        gitcommit
        gitignore
        glsl
        go
        html
        jsdoc
        json
        json5
        jsonc
        lua
        luadoc
        luap
        luau
        latex
        markdown
        markdown_inline
        matlab
        nix
        nu
        objc
        perl
        python
        query
        r
        regex
        rust
        swift
        todotxt
        toml
        tsx
        typst
        vim
        vimdoc
        xml
        yaml
        zig
      ];
    };
  };
}
