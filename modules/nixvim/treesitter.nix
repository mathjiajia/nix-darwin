{ lib, config, ... }:
let
  inherit (config.plugins.treesitter.package) builtGrammars;
in
{
  plugins.treesitter = {
    enable = true;
    grammarPackages = with builtGrammars; [
      bash
      bibtex
      c
      comment
      cpp
      css
      diff
      fish
      gitcommit
      gitignore
      html
      javascript
      json
      latex
      lua
      luap
      make
      markdown
      markdown_inline
      matlab
      nix
      nu
      python
      query
      r
      regex
      rust
      scheme
      swift
      toml
      typst
      vim
      vimdoc
      yaml
      zsh
    ];
    luaConfig.content = lib.mkForce ''
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nixvim_treesitter", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local filetype = vim.bo[buf].filetype
          local lang = vim.treesitter.language.get_lang(filetype)
          if not lang then
            return
          end
          local has_parser = vim.treesitter.language.add(lang)
          if not has_parser then
            return
          end

          -- Look for query files without compiling them; compiling the latex
          -- highlights query alone takes over 100 ms.
          local function has_query(query_name)
            return #vim.treesitter.query.get_files(lang, query_name) > 0
          end

          local function add_undo_ftplugin(command)
            vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. " | " or "") .. command
          end

          if has_query("highlights") then
            -- Start highlighting after the first screen update, so compiling the
            -- query doesn't hold up opening the file. Setting b:ts_highlight now
            -- stops the syntaxset autocmd from loading regex syntax meanwhile,
            -- and noplainbuffer stops spell from checking every word until
            -- treesitter marks the @spell regions.
            vim.b[buf].ts_highlight = true
            local spelloptions = vim.bo[buf].spelloptions
            local add_noplainbuffer = not vim.tbl_contains(vim.split(spelloptions, ",", { plain = true }), "noplainbuffer")
            if add_noplainbuffer then
              vim.bo[buf].spelloptions = spelloptions == "" and "noplainbuffer" or spelloptions .. ",noplainbuffer"
            end
            vim.schedule(function()
              if
                vim.api.nvim_buf_is_valid(buf)
                and vim.bo[buf].filetype == filetype
                and not vim.treesitter.highlighter.active[buf]
              then
                vim.treesitter.start(buf, lang)
              end
            end)
            add_undo_ftplugin(("call v:lua.vim.treesitter.stop(%d) | unlet! b:ts_highlight"):format(buf))
            -- After stop, which restores the spelloptions saved when highlighting started.
            if add_noplainbuffer then
              add_undo_ftplugin("setlocal spelloptions-=noplainbuffer")
            end
          end

          if has_query("indents") then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            add_undo_ftplugin('setlocal indentexpr<')
          end

          if has_query("folds") then
            vim.wo[0][0].foldmethod = "expr"
            vim.wo[0][0].foldexpr = vim.treesitter.foldexpr
            add_undo_ftplugin("setlocal foldexpr< foldmethod<")
          end
        end,
      })
    '';
  };
}
