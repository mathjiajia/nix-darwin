{ ... }:
{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    settings.on_attach = ''
      function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- stylua: ignore start
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff This (File)" })
        map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end
    '';
  };
}
