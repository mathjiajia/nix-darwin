{ lib, ... }:
{
  plugins.treesitter = {
    enable = true;
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

          local function has_query(query_name)
            return vim.treesitter.query.get(lang, query_name) ~= nil
          end

          local function add_undo_ftplugin(command)
            vim.b.undo_ftplugin = (vim.b.undo_ftplugin and vim.b.undo_ftplugin .. " | " or "") .. command
          end

          if has_query("highlights") then
            vim.treesitter.start(buf, lang)
            add_undo_ftplugin(("call v:lua.vim.treesitter.stop(%d)"):format(buf))
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
