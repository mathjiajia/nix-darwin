{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = [pkgs.python3Packages.ipython];

    plugins.overseer = {
      enable = true;
      settings = {
        # strategy = "jobstart";
        templates = ["builtin" "user.builder" "user.runner"];
      };
    };

    keymaps = [
      {
        key = "<leader>rf";
        action = "<Cmd>OverseerRun RunFile<CR>";
        options.silent = true;
        options.desc = "Run File";
      }
      {
        key = "<leader>rr";
        action = "<Cmd>OverseerRun OpenREPL<CR>";
        options.silent = true;
        options.desc = "Open REPL";
      }
    ];

    extraFiles = {
      "lua/overseer/template/user/builder.lua".text =
        # lua
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

      "lua/overseer/template/user/runner.lua".text =
        # lua
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
          					components = { "default" },
          				}
          			end,
          			priority = 5,
          		})

          		cb(ret)
          	end,
          }
        '';
    };
  };
}
