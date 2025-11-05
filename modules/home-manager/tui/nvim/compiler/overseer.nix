{ lib, pkgs, ... }:
{
  programs.nixvim = {
    plugins.overseer = {
      enable = true;
      luaConfig.content = lib.mkForce "";
      package = pkgs.vimPlugins.overseer-nvim.overrideAttrs (oldAttrs: {
        nvimSkipModules = (oldAttrs.nvimSkipModules or [ ]) ++ [
          "resession.extensions.overseer"
          "neotest.consumers.overseer"
          "neotest.client.strategies.overseer"
          "cmp_overseer"
        ];
        postInstall =
          (oldAttrs.postInstall or "")
          # sh
          + ''
            mv $out/doc/{recipes.md,overseer-nvim_recipes.md}
            rm -r $out/lua/{cmp_overseer,lualine,neotest,resession}
          '';
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
      "lua/overseer/template/user/gcc_debug.lua".text =
        # lua
        ''
          return {
          	name = "clang: debug build",
          	condition = { filetype = { "c", "cpp" } },
          	builder = function()
          		local file = vim.fn.expand("%:p")
          		local outfile = vim.fn.expand("%:p:r") .. ".out"
          		local compiler = vim.bo.filetype == "c" and "clang" or "clang++"
          		return {
          			cmd = { compiler },
          			args = { "-fcolor-diagnostics", "-fansi-escape-codes", "-g", file, "-o", outfile },
          			components = {
          				{
          					"on_output_quickfix",
          					open_on_exit = "failure",
          				},
          				"on_complete_notify",
          				"default",
          			},
          		}
          	end,
          }
        '';

      "lua/overseer/template/user/clang_build.lua".text =
        # lua
        ''
          return {
          	name = "clang: build",
          	builder = function()
          		local file = vim.fn.expand("%:p")
          		local outfile = vim.fn.expand("%:p:r") .. ".out"
          		local compiler = vim.bo.filetype == "c" and "clang" or "clang++"
          		return {
          			cmd = { compiler },
          			args = { file, "-o", outfile },
          			components = {
          				{
          					"on_output_quickfix",
          					open_on_exit = "failure",
          				},
          				"on_complete_notify",
          				"default",
          			},
          		}
          	end,
          	condition = {
          		filetype = { "c", "cpp" },
          	},
          }
        '';
      "lua/overseer/template/user/clang_build_run.lua".text =
        # lua
        ''
          return {
          	name = "clang: build and run",
          	condition = { filetype = { "c", "cpp" } },
          	builder = function()
          		local outfile = vim.fn.expand("%:p:r") .. ".out"
          		return {
          			cwd = vim.fn.expand("%:p:h"),
          			cmd = { outfile },
          			components = {
          				{
          					"dependencies",
          					task_names = { "clang: build" },
          				},
          				{ "open_output", focus = true },
          				"default",
          			},
          		}
          	end,
          }
        '';

      "lua/overseer/template/user/swiftc_debug.lua".text =
        # lua
        ''
          return {
          	name = "swiftc: debug build",
          	condition = { filetype = { "swift" } },
          	builder = function()
          		local file = vim.fn.expand("%:p")
          		return {
          			cmd = { "swiftc" },
          			args = { "-g", file },
          		}
          	end,
          }
        '';

      "lua/overseer/template/user/run_script.lua".text =
        # lua
        ''
          return {
          	name = "run script",
          	condition = { filetype = { "lua", "python", "sh" } },
          	builder = function()
          		local file = vim.fn.expand("%:p")
          		local cmd = { file }
          		if vim.bo.filetype == "lua" then
          			cmd = { "nvim", "-l", file }
          		elseif vim.bo.filetype == "python" then
          			cmd = { "python", file }
          		end
          		return { cmd = cmd }
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
          			args = {
          				"-pdf",
          				"-interaction=nonstopmode",
          				"-synctex=1",
          			},
          			components = {
          				{ "on_output_quickfix", open = true },
          				{ "default" },
          			},
          		}
          	end,
          }
        '';
    };
  };
}
