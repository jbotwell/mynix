vim.keymap.set('n', '<Leader>dc', require('dap').continue)
vim.keymap.set('n', '<Leader>db', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<Leader>ds', require('dap').step_over)
vim.keymap.set('n', '<Leader>di', require('dap').step_into)
vim.keymap.set('n', '<Leader>do', require('dap').step_out)
vim.keymap.set('n', '<Leader>dl', require('dap').run_last)

local dap = require("dap")

-- js/ts
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = {"/home/john/programs/js-debug/src/dapDebugServer.js", "${port}"}
    }
}

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}"
    }
}

dap.configurations.typescript = {
    {
        type = 'pwa-node',
        request = 'launch',
        name = "Launch file",
        runtimeExecutable = "deno",
        runtimeArgs = {"run", "--inspect-wait", "--allow-all"},
        program = "${file}",
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229
    }
}

-- dotnet
dap.adapters.coreclr = {
    type = 'executable',
    command = '/home/john/.nix-profile/bin/netcoredbg',
    args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll: ',
                                vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end
    }
}
