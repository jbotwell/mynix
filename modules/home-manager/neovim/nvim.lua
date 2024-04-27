-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- dap
local dap = require("dap")

-- vscode-js-debug
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
	-- relies on js-debug set in neovim.nix
        args = {"/home/john/.config/js-debug/src/dapDebugServer.js", "${port}"}
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
