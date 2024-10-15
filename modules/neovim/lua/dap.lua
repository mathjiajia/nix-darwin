-- dap signs
local icons = {
    Stopped = "󰁕 ",
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = " ",
    LogPoint = ".>",
}
for name, sign in pairs(icons) do
    name = "Dap" .. name
    vim.fn.sign_define(name, { text = sign, texthl = name, numhl = "" })
end

local dap = require("dap")

dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = { source_filetype = "python" },
        })
    else
        cb({
            type = "executable",
            command = vim.fn.stdpath("data") .. "mason/packages/debugpy/venv/bin/python",
            args = { "-m", "debugpy.adapter" },
            options = { source_filetype = "python" },
        })
    end
end

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",

        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
            else
                return "/opt/homebrew/bin/python3"
            end
        end,
    },
}

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        sourceLanguages = { "cpp" },
    },
}

dap.configurations.c = dap.configurations.cpp
