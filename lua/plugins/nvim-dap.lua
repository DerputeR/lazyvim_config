return {
    "mfussenegger/nvim-dap",
    config = function(_)
        local dap = require("dap")
        dap.adapters.gdb = {
            type = "executable",
            command = "/usr/bin/x86_64-w64-mingw32-gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
        }
        dap.adapters.bashdb = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
            name = "bashdb",
        }
        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
            {
                name = "Select and attach to process",
                type = "gdb",
                request = "attach",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                pid = function()
                    local name = vim.fn.input("Executable name (filter): ")
                    return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = "${workspaceFolder}",
            },
            {
                name = "Attach to gdbserver :1234",
                type = "gdb",
                request = "attach",
                target = "localhost:1234",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
            },
        }
        dap.configurations.cpp = dap.configurations.c
        dap.configurations.rust = dap.configurations.rust
        dap.configurations.sh = {
            {
                type = "bashdb",
                request = "launch",
                name = "Launch file",
                showDebugOutput = true,
                pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
                pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
                trace = true,
                file = "${file}",
                program = "${file}",
                cwd = "${workspaceFolder}",
                pathCat = "cat",
                pathBash = "/bin/bash",
                pathMkfifo = "mkfifo",
                pathPkill = "pkill",
                args = {},
                argsString = "",
                env = {},
                terminalKind = "integrated",
            },
        }
    end,
}
