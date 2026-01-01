{ lib, pkgs, ... }:
{
  lsp.servers.copilot = {
    enable = false;
    config = {
      cmd = [
        "${lib.getExe pkgs.copilot-language-server}"
        "--stdio"
      ];
      root_markers = [ ".git" ];
      init_options = {
        editorInfo = {
          name = "Neovim";
          version.__raw = "tostring(vim.version())";
        };
        editorPluginInfo = {
          name = "Neovim";
          version.__raw = "tostring(vim.version())";
        };
      };
      settings.telemetry.telemetryLevel = "off";
      on_attach.__raw = ''
        function(client, bufnr)
        	local function sign_in()
        		client:request("signIn", vim.empty_dict(), function(err, result)
        			if err then
        				vim.notify(err.message, vim.log.levels.ERROR)
        				return
        			end
        			if result.command then
        				local code = result.userCode
        				local command = result.command
        				vim.fn.setreg("+", code)
        				vim.fn.setreg("*", code)
        				local continue = vim.fn.confirm(
        					"Copied your one-time code to clipboard.\n" .. "Open the browser to complete the sign-in process?",
        					"&Yes\n&No"
        				)
        				if continue == 1 then
        					client:exec_cmd(command, { bufnr = bufnr }, function(cmd_err, cmd_result)
        						if cmd_err then
        							vim.notify(cmd_err.message, vim.log.levels.ERROR)
        							return
        						end
        						if cmd_result.status == "OK" then
        							vim.notify("Signed in as " .. cmd_result.user .. ".")
        						end
        					end)
        				end
        			end

        			if result.status == "PromptUserDeviceFlow" then
        				vim.notify("Enter your one-time code " .. result.userCode .. " in " .. result.verificationUri)
        			elseif result.status == "AlreadySignedIn" then
        				vim.notify("Already signed in as " .. result.user .. ".")
        			end
        		end)
        	end

        	local function sign_out()
        		client:request("signOut", vim.empty_dict(), function(err, result)
        			if err then
        				vim.notify(err.message, vim.log.levels.ERROR)
        				return
        			end
        			if result.status == "NotSignedIn" then
        				vim.notify("Not signed in.")
        			end
        		end)
        	end

        	vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignIn", sign_in, { desc = "Sign in Copilot with GitHub" })
        	vim.api.nvim_buf_create_user_command(bufnr, "LspCopilotSignOut", sign_out, { desc = "Sign out Copilot with GitHub" })
        end
      '';
    };
  };
}
