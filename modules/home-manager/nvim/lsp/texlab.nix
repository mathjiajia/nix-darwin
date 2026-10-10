{ lib, pkgs, ... }: {
  lsp.servers.texlab = {
    enable = true;
    package = null;
    config = {
      cmd = [ "${lib.getExe pkgs.texlab}" ];
      filetypes = [
        "tex"
        "plaintex"
        "bib"
      ];
      root_markers = [
        ".git"
        ".latexmkrc"
        "latexmkrc"
        ".texlabroot"
        "texlabroot"
        "Tectonic.toml"
      ];
      settings.texlab = {
        build = {
          executable = "latexmk";
          args = [
            "-interaction=nonstopmode"
            "-synctex=1"
            "%f"
          ];
          onSave = true;
          forwardSearchAfter = false;
        };
        forwardSearch = {
          executable = "${lib.getExe pkgs.sioyek}";
          args = [
            "--reuse-window"
            "--execute-command"
            "turn_on_synctex"
            "--inverse-search"
            "${lib.getExe pkgs.texlab} inverse-search --input \"%%1\" --line1 %%2"
            "--forward-search-file"
            "%f"
            "--forward-search-line"
            "%l"
            "%p"
          ];
          # executable = "/Applications/Skim.app/Contents/SharedSupport/displayline";
          # args = [
          #   "-r"
          #   "%l"
          #   "%p"
          #   "%f"
          # ];
        };
        chktex = {
          onOpenAndSave = false;
          onEdit = false;
        };
        diagnosticsDelay = 300;
        diagnostics.ignoredPatterns = [
          "Overfull"
          "Underfull"
          "Package hyperref Warning"
          "Float too large for page"
          "contains only floats"
        ];
        latexFormatter = "tex-fmt";
        formatterLineLength = 120;
      };
      on_attach.__raw = ''
        function (client, bufnr)
        	local function buf_build()
        		local win = vim.api.nvim_get_current_win()
        		local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
        		client:request("textDocument/build", params, function (err, result)
        			if err then
        				error(tostring(err))
        			end
        			local texlab_build_status = { [0] = "Success", [1] = "Error", [2] = "Failure", [3] = "Cancelled" }
        			vim.notify("Build " .. texlab_build_status[result.status], vim.log.levels.INFO)
        		end, bufnr
        		)
        	end

        	local function buf_search()
        		local win = vim.api.nvim_get_current_win()
        		local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
        		client:request("textDocument/forwardSearch", params, function (err, result)
        			if err then
        				error(tostring(err))
        			end
        			local texlab_forward_status = { [0] = "Success", [1] = "Error", [2] = "Failure", [3] = "Unconfigured" }
        			vim.notify("Search " .. texlab_forward_status[result.status], vim.log.levels.INFO)
        		end, bufnr
        		)
        	end

        	local function buf_cancel_build()
        		return client:exec_cmd({
        			title = "cancel",
        			command = "texlab.cancelBuild"
        		}, { bufnr = bufnr })
        	end

        	local function dependency_graph()
        		client:exec_cmd({ command = "texlab.showDependencyGraph" }, { bufnr = bufnr }, function (err, result)
        			if err then
        				return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
        			end
        			vim.notify("The dependency graph has been generated:\n" .. result, vim.log.levels.INFO)
        		end)
        	end

        	local function command_factory(cmd)
        		local cmd_tbl = { Auxiliary = "texlab.cleanAuxiliary", Artifacts = "texlab.cleanArtifacts" }
        		return function ()
        			return client:exec_cmd({
        				title = ("clean_%s"):format(cmd),
        				command = cmd_tbl[cmd],
        				arguments = { { uri = vim.uri_from_bufnr(bufnr) } }
        			},
        				{ bufnr = bufnr }, function (err, _)
        					if err then
        						vim.notify(("Failed to clean %s files: %s"):format(cmd, err.message), vim.log.levels.ERROR)
        					else
        						vim.notify(("Command %s executed successfully"):format(cmd), vim.log.levels.INFO)
        					end
        				end)
        		end
        	end

        	local function buf_change_env()
        		vim.ui.input({ prompt = "New environment name: " }, function (input)
        			if not input or input == "" then
        				return vim.notify("No environment name provided", vim.log.levels.WARN)
        			end
        			local win = vim.api.nvim_get_current_win()
        			local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
        			params.newName = input
        			return client:exec_cmd({
        				title = "change_environment",
        				command = "texlab.changeEnvironment",
        				arguments = { params }
        			}, { bufnr = bufnr })
        		end)
        	end

        	local function close_env()
        		local win = vim.api.nvim_get_current_win()
        		client:exec_cmd({
        			command = "texlab.findEnvironments",
        			arguments = { vim.lsp.util.make_position_params(win, client.offset_encoding) }
        		},
        			{ bufnr = bufnr }, function (err, result)
        				if err then
        					return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
        				end
        				if #result == 0 then
        					return vim.notify("No environment found", vim.log.levels.WARN)
        				end

        				local text = result[#result].name.text
        				vim.api.nvim_paste(("\\end{%s}"):format(text), false, -1)
        			end)
        	end

        	local toggle_star = function ()
        		local win = vim.api.nvim_get_current_win()
        		local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
        		client:exec_cmd({
        			command = "texlab.findEnvironments",
        			arguments = { params }
        		},
        			{ bufnr = bufnr }, function (err, result)
        				if err then
        					return vim.notify(err.code .. ": " .. err.message, vim.log.levels.ERROR)
        				end
        				if #result == 0 then
        					return vim.notify("No environment found", vim.log.levels.WARN)
        				end

        				local text = result[#result].name.text
        				local new = text:sub(-1) == "*" and text:sub(1, -2) or text .. "*"
        				params.newName = new
        				client:exec_cmd({
        					command = "texlab.changeEnvironment",
        					arguments = { params }
        				}, { bufnr = bufnr })
        			end)
        	end

        	for _, cmd in ipairs({
        		{ name = "TexlabBuild", fn = buf_build, desc = "Build the current buffer" },
        		{ name = "TexlabForward", fn = buf_search, desc = "Forward search from current position" },
        		{ name = "TexlabCancelBuild", fn = buf_cancel_build, desc = "Cancel the current build" },
        		{ name = "TexlabDependencyGraph", fn = dependency_graph, desc = "Show the dependency graph" },
        		{ name = "TexlabCleanArtifacts", fn = command_factory("Artifacts"), desc = "Clean the artifacts" },
        		{ name = "TexlabCleanAuxiliary", fn = command_factory("Auxiliary"), desc = "Clean the auxiliary files" },
        		{ name = "TexlabChangeEnvironment", fn = buf_change_env, desc = "Change the environment at current position" }
        	}) do
        		vim.api.nvim_buf_create_user_command(bufnr, "Lsp" .. cmd.name, cmd.fn, { desc = cmd.desc })
        	end

        	for _, map in ipairs({
        		{ lhs = "<localleader>ll", fn = buf_build, desc = "Build the current buffer" },
        		{ lhs = "<localleader>lf", fn = buf_search, desc = "Forward search from current position" },
        		{ lhs = "<localleader>lc", fn = buf_cancel_build, desc = "Cancel the current build" },
        		{ lhs = "cse", fn = buf_change_env, desc = "Change the current environment" },
        		{ lhs = ";]", fn = close_env, desc = "Close the current environment", mode = "i" },
        		{ lhs = "tss", fn = toggle_star, desc = "Toggle starred environment" }
        	}) do
        		vim.keymap.set(map.mode or "n", map.lhs, map.fn, { buffer = bufnr, desc = map.desc })
        	end
        end
      '';
    };
  };
}
