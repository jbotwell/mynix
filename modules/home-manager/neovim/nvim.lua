-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- dap
local dap = require("dap")

-- vscode-js-debug
-- TODO: fix this to do the git submodule thing
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
