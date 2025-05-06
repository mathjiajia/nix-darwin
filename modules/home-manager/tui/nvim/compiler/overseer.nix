{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = [pkgs.python3Packages.ipython];

    plugins.overseer = {
      enable = true;
      package = pkgs.vimPlugins.overseer-nvim.overrideAttrs (oldAttrs: {
        postInstall =
          oldAttrs.postInstall
            or ""
          + # sh
          ''mv $out/doc/recipes.md $out/doc/overseer-nvim_recipes.md'';
      });
      settings.templates = ["builtin" "user.builder" "user.runner"];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>rl";
        action = "<Cmd>OverseerToggle<CR>";
        options.desc = "Task List";
      }
      {
        mode = "n";
        key = "<leader>rr";
        action = "<Cmd>OverseerRun<CR>";
        options.desc = "Run Task";
      }
      {
        mode = "n";
        key = "<leader>rb";
        action = "<Cmd>OverseerBuild<CR>";
        options.desc = "Task Builder";
      }
    ];

    extraFiles = {
      "lua/overseer/template/user/builder.lua".text =
        # lua
        ''
          return { "user.builder.clang", "user.builder.swift" }
        '';

      "lua/overseer/template/user/builder/clang.lua".text =
        # lua
        ''
          local clang = "clang"

          return {
          	cached_key = function()
          		return vim.fn.expand("%:p")
          	end,
          	condition = { filetype = { "c", "cpp" } },
          	generator = function(_, cb)
          		local file = vim.fn.expand("%:p")
          		local exec_file = vim.fn.expand("%:p:r")
          		cb({
          			{
          				name = "C/C++: clang build active file",
          				builder = function()
          					return {
          						cmd = { clang },
          						args = { "-fcolor-diagnostics", "-fansi-escape-codes", "-g", file, "-o", exec_file },
          						cwd = vim.fn.expand("%:p:h"),
          					}
          				end,
          				priority = 6,
          			},
          			{
          				name = "Build and Run with " .. clang,
          				builder = function()
          					return {
          						cmd = { clang },
          						args = { file, "-o", exec_file },
          						cwd = vim.fn.expand("%:p:h"),
          						components = { "open_output", "default", { "run_after", task_names = { { cmd = exec_file } } } },
          					}
          				end,
          				priority = 2,
          			},
          		})
          	end,
          }
        '';

      "lua/overseer/template/user/builder/swift.lua".text =
        # lua
        ''
          return {
          	cached_key = function()
          		return vim.fn.expand("%:p")
          	end,
          	condition = { filetype = { "swift" } },
          	generator = function(_, cb)
          		cb({
          			{
          				name = "swiftc: Build Debug",
          				builder = function()
          					local file = vim.fn.expand("%:p")
          					return {
          						cmd = { "swiftc" },
          						args = { "-g", file },
          						cwd = vim.fn.expand("%:p:h"),
          					}
          				end,
          				priority = 6,
          			},
          		})
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
          	m2 = { name = "Macaulay2", cmd = "M2", repl = "M2" },
          	python = { name = "Python", cmd = "python", repl = "ipython" },
          	r = { name = "R", cmd = "Rscript", repl = "R" },
          	lua = { name = "Lua", cmd = { "nvim", "-l" }, repl = "lua" },
          	swift = { name = "Swift", cmd = "swift", repl = { "swift", "repl" } },
          }

          local repl_counters = {}

          return {
          	condition = { filetype = vim.tbl_keys(filerunners) },
          	generator = function(_, cb)
          		local ft = filerunners[vim.bo.filetype]
          		if not ft then
          			return
          		end

          		local file = vim.fn.expand("%:p")
          		local file_basename = vim.fn.expand("%:t:r")
          		local tasks = {}

          		tasks[#tasks + 1] = {
          			name = "RunFile",
          			builder = function()
          				return {
          					cmd = ft.cmd,
          					args = { file },
          					name = "Running " .. file_basename,
          					components = { "open_output", "default", "unique" },
          				}
          			end,
          			priority = 4,
          		}

          		tasks[#tasks + 1] = {
          			name = "OpenREPL",
          			builder = function()
          				repl_counters[vim.bo.filetype] = (repl_counters[vim.bo.filetype] or 0) + 1
          				return {
          					cmd = ft.repl,
          					name = ft.name .. " REPL " .. repl_counters[vim.bo.filetype],
          					components = { "open_output", "default" },
          				}
          			end,
          			priority = 5,
          		}

          		cb(tasks)
          	end,
          }
        '';
    };
  };
}
