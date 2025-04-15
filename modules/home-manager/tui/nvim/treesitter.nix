{pkgs, ...}: {
  programs.nixvim.extraPackages = [pkgs.tree-sitter];
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        bibtex
        c
        commonlisp
        css
        csv
        editorconfig
        diff
        glsl
        fish
        git_config
        git_rebase
        gitattributes
        gitcommit
        gitignore
        html
        javascript
        json
        jsonc
        latex
        lua
        luadoc
        luap
        markdown
        markdown_inline
        matlab
        nix
        python
        query
        r
        regex
        requirements
        swift
        todotxt
        toml
        tsx
        typst
        vim
        vimdoc
        yaml
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    treesitter-context.enable = true;
  };
}
