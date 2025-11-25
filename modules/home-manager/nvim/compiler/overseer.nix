{ pkgs, ... }:
{
  plugins.overseer = {
    enable = true;
    # w/o calling setup causes dap integration bug
    package = pkgs.vimPlugins.overseer-nvim.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        # sh
        + ''mv $out/doc/{recipes.md,overseer-nvim_recipes.md}'';
    });
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>or";
      action = "<Cmd>OverseerRun<CR>";
      options.desc = "[O]verseer [R]un";
    }
    {
      mode = "n";
      key = "<leader>os";
      action = "<Cmd>OverseerShell<CR>";
      options.desc = "[O]verseer [S]hell";
    }
    {
      mode = "n";
      key = "<leader>oo";
      action = "<Cmd>OverseerToggle!<CR>";
      options.desc = "[O]verseer [O]pen";
    }
  ];

  extraFiles = {
    "lua/overseer/template/user/clang_debug_build.lua".text =
      # lua
      ''
        return {
        	name = "C/C++: clang debug build",
        	condition = { filetype = { "c", "cpp" } },
        	builder = function()
        		local file = vim.fn.expand("%:p")
        		local outfile = vim.fn.expand("%:p:r")
        		local compiler = vim.bo.filetype == "c" and "/usr/bin/clang" or "/usr/bin/clang++"
        		return {
        			cmd = { compiler },
        			args = { "-fcolor-diagnostics", "-fansi-escape-codes", "-g", file, "-o", outfile },
        			components = { { "on_output_quickfix", open_on_exit = "failure" } },
        		}
        	end,
        }
      '';
    "lua/overseer/template/user/clang_build.lua".text =
      # lua
      ''
        return {
        	name = "C/C++: clang build",
        	condition = { filetype = { "c", "cpp" } },
        	builder = function()
        		local file = vim.fn.expand("%:p")
        		local outfile = vim.fn.expand("%:p:r")
        		local compiler = vim.bo.filetype == "c" and "/usr/bin/clang" or "/usr/bin/clang++"
        		return {
        			cmd = { compiler },
        			args = { file, "-o", outfile },
        			components = {
        				{ "on_output_quickfix", open_on_exit = "failure" },
        				"default",
        			},
        		}
        	end,
        }
      '';
    "lua/overseer/template/user/clang_run.lua".text =
      # lua
      ''
        return {
        	name = "C/C++: clang build and run",
        	condition = { filetype = { "c", "cpp" } },
        	builder = function()
        		local outfile = vim.fn.expand("%:p:r")
        		return {
        			cmd = { outfile },
        			components = {
        				{ "dependencies", task_names = { "C/C++: clang build" } },
        				{ "open_output", focus = true },
        				"default",
        			},
        		}
        	end,
        }
      '';

    "lua/overseer/template/user/swiftc_debug_build.lua".text =
      # lua
      ''
        return {
        	name = "swift: swiftc debug build",
        	condition = { filetype = { "swift" } },
        	builder = function()
        		local file = vim.fn.expand("%:p")
        		return {
        			cmd = { "/usr/bin/swiftc" },
        			args = { "-g", file },
        			components = { { "on_output_quickfix", open_on_exit = "failure" } },
        		}
        	end,
        }
      '';
    # "lua/overseer/template/user/swift_proj.lua".text =
    #   # lua
    #   ''
    #     return {
    #     	name = "swift: Build Debug (Project)",
    #     	condition = { filetype = { "swift" } },
    #     	builder = function()
    #     		return {
    #     			cwd = vim.fs.root(0, { "Package.swift", ".git" }),
    #     			cmd = { "/usr/bin/swift" },
    #     			args = { "test" },
    #     			components = { { "on_output_quickfix", open_on_exit = "failure" } },
    #     		}
    #     	end,
    #     }
    #   '';

    "lua/overseer/template/user/run_script.lua".text =
      # lua
      ''
        return {
        	name = "run script",
        	condition = { filetype = { "lua", "sh", "swift" } },
        	builder = function()
        		local file = vim.fn.expand("%:p")
        		local cmd = { file }
        		if vim.bo.filetype == "lua" then
        			cmd = { "nvim", "-l", file }
        		elseif vim.bo.filetype == "swift" then
        			cmd = { "swift", file }
        		end
        		return { cmd = cmd }
        	end,
        }
      '';

    "lua/overseer/template/user/run_python.lua".text =
      # lua
      ''
        return {
        	name = "run python",
        	condition = { filetype = { "python" } },
        	builder = function()
        		local file = vim.fn.expand("%:p")
        		local root = vim.fs.root(file, { "pyproject.toml", ".venv" })
        		local cmd

        		if root then
        			cmd = { "uv", "run" }
        		else
        			cmd = { "python" }
        		end

        		return {
        			cmd = cmd,
        			args = { file },
        			components = {
        				{ "open_output", focus = true },
        				"default",
        			},
        		}
        	end,
        }
      '';

    "lua/overseer/template/user/latexmk.lua".text =
      # lua
      ''
        return {
        	name = "latexmk",
        	condition = { filetype = { "tex" } },
        	builder = function()
        		return {
        			cmd = { "latexmk" },
        			args = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
        			components = {
        				{ "on_output_quickfix", open_on_exit = "failure" },
        				{ "default" },
        			},
        		}
        	end,
        }
      '';
  };
}
