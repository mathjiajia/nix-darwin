{ ... }:
{
  programs.nixvim.extraFiles = {
    "after/ftplugin/checkhealth.lua".text = # lua
      ''
        vim.opt_local.buflisted = false
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(0, false)
        end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/grug-far.lua".text = # lua
      ''
        vim.opt_local.buflisted = false
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(0, false)
        end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/help.lua".text = # lua
      ''
        vim.opt_local.buflisted = false
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(0, false)
        end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/man.lua".text = # lua
      "vim.opt_local.buflisted = false";

    "after/ftplugin/markdown.lua".text = # lua
      ''
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true
        vim.keymap.set("i", "<C-h>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Crect Last Spelling" })
      '';

    "after/ftplugin/norg.lua".text = # lua
      ''
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true
        vim.keymap.set("i", "<C-h>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Crect Last Spelling" })
      '';

    "after/ftplugin/qf.lua".text = # lua
      ''
        vim.opt_local.buflisted = false
        vim.keymap.set("n", "q", function()
          vim.api.nvim_win_close(0, false)
        end, { buffer = 0, silent = true })
      '';

    "after/ftplugin/tex.lua".text = # lua
      ''
        vim.opt_local.conceallevel = 2
        vim.opt_local.spell = true
        vim.keymap.set("i", "<C-h>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buffer = 0, desc = "Crect Last Spelling" })
      '';

    "lua/chadrc.lua".text = # lua
      ''
        -- vim.keymap.set("n", "<RightMouse>", function()
        --   vim.cmd.exec('"normal! \\<RightMouse>"')
        --   local options = vim.bo.ft == "NvimTree" and "nvimtree" or "gitsigns"
        --   require("menu").open(options, { mouse = true })
        -- end, { desc = "Menu" })
        -- vim.keymap.set("n", "<C-t>", function() require("menu").open("default") end, { desc = "Menu" })
        vim.keymap.set("n", "<leader>tm", function() require("nvchad.themes").open() end, { desc = "Themes Picker" })

        local options = {
          base46 = {
            theme = "nord",
            transparency = false,
            theme_toggle = { "nord", "nord" },
            integrations = {
              "codeactionmenu",
              "dap",
              "markview",
              "notify",
              "nvshades",
              "rainbowdelimiters",
              "semantic_tokens",
            },
            hl_add = {
              DashboardHeader = { fg = "yellow" },
              DashboardFooter = { fg = "dark_purple", italic = true },
              DashboardProjectTitle = { fg = "nord_blue" },
              DashboardProjectIcon = { fg = "sun" },
              DashboardMruTitle = { fg = "teal" },
              DashboardFiles = { italic = true },
              DashboardShortCutIcon = { fg = "vibrant_green" },
            },
          },
          ui = { statusline = { order = { "mode", "file", "git", "%=", "diagnostics", "lsp", "cwd", "cursor" } } },
          nvdash = {
            header = {
              [[                                                                       ]],
              [[                                                                     ]],
              [[       ████ ██████           █████      ██                     ]],
              [[      ███████████             █████                             ]],
              [[      █████████ ███████████████████ ███   ███████████   ]],
              [[     █████████  ███    █████████████ █████ ██████████████   ]],
              [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
              [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
              [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
              [[                                                                       ]],
              [[                                                                       ]],
            },
            buttons = {
              { txt = "  Find File", keys = "ff", cmd = "FzfLua files" },
              { txt = "  Recent Files", keys = "fo", cmd = "FzfLua oldfiles" },
              { txt = "  Live Grep", keys = "sg", cmd = "FzfLua live_grep" },
              { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
              { txt = "  Cheatsheet", keys = "ch", cmd = "NvCheatsheet" },
            },
          },
          term = {
            winopts = { number = false, relativenumber = false },
            float = { width = 1, height = 1, border = "rounded" },
          },
          lsp = { signature = true },
          cheatsheet = { excluded_groups = { ":help", "autopairs", "Opens" } },
        }
        return options
      '';

    "lua/overseer/template/user/builder.lua".text = # lua
      ''
        local builders = {
          c = {
            name = "C",
            filerunner = function()
              return "cd "
                .. vim.fn.expand("%:p:h")
                .. "&& gcc "
                .. vim.fn.expand("%:p")
                .. " -o "
                .. vim.fn.expand("%:p:r")
                .. " && "
                .. vim.fn.expand("%:p:r")
            end,
          },
          cpp = {
            name = "C++",
            filerunner = function()
              return "cd "
                .. vim.fn.expand("%:p:h")
                .. "&& g++ "
                .. vim.fn.expand("%:p")
                .. " -o "
                .. vim.fn.expand("%:p:r")
                .. " && "
                .. vim.fn.expand("%:p:r")
            end,
          },
        }

        return {
          condition = { filetype = vim.tbl_keys(builders) },
          generator = function(_, cb)
            local ft = builders[vim.bo.filetype]

            local ret = {
              {
                name = "RunFile",
                builder = function()
                  return {
                    cmd = ft.filerunner(),
                    name = "Running " .. vim.fn.expand("%:t:r"),
                    components = { "default", "unique" },
                  }
                end,
                priority = 4,
              },
            }

            cb(ret)
          end,
        }
      '';

    "lua/overseer/template/user/runner.lua".text = # lua
      ''
        local filerunners = {
          sh = { name = "Shell", cmd = "sh", repl = "sh" },
          bash = { name = "Bash", cmd = "bash", repl = "bash" },
          zsh = { name = "Zsh", cmd = "zsh", repl = "zsh" },
          fish = { name = "Fish", cmd = "fish", repl = "fish" },
          python = { name = "Python", cmd = "python", repl = "ipython" },
          r = { name = "R", cmd = "Rscript", repl = "R" },
          lua = { name = "Lua", cmd = { "nvim", "-l" }, repl = "lua" },
          swift = { name = "Swift", cmd = "swift", repl = { "swift", "repl" } },
        }

        return {
          condition = { filetype = vim.tbl_keys(filerunners) },
          generator = function(_, cb)
            local ft = filerunners[vim.bo.filetype]
            local file = vim.fn.expand("%:p")
            local ret = {}

            table.insert(ret, {
              name = "RunFile",
              builder = function()
                return {
                  cmd = ft.cmd,
                  args = { file },
                  name = "Running " .. vim.fn.expand("%:t:r"),
                  components = { "default", "unique" },
                }
              end,
              priority = 4,
            })

            table.insert(ret, {
              name = "OpenREPL",
              builder = function()
                if ft.num then
                  ft.num = ft.num + 1
                else
                  ft.num = 1
                end
                return {
                  cmd = ft.repl,
                  name = ft.name .. " REPL " .. ft.num,
                  components = {
                    "default",
                  },
                }
              end,
              priority = 5,
            })

            cb(ret)
          end,
        }
      '';
  };
}
