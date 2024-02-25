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

-- python
-- debugpy must be installed to this virtual environment
-- the process is described in the 'nvim-dap-python' readme
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

-- keybindings
local wk = require("which-key")
local dapui = require("dapui")
wk.register({
    c = {
        name = "ChatGPT",
        c = {"<cmd>ChatGPT<CR>", "ChatGPT"},
        e = {
            "<cmd>ChatGPTEditWithInstruction<CR>",
            "Edit with instruction",
            mode = {"n", "v"}
        },
        g = {
            "<cmd>ChatGPTRun grammar_correction<CR>",
            "Grammar Correction",
            mode = {"n", "v"}
        },
        t = {"<cmd>ChatGPTRun translate<CR>", "Translate", mode = {"n", "v"}},
        k = {"<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = {"n", "v"}},
        d = {"<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = {"n", "v"}},
        a = {"<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = {"n", "v"}},
        o = {
            "<cmd>ChatGPTRun optimize_code<CR>",
            "Optimize Code",
            mode = {"n", "v"}
        },
        s = {"<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = {"n", "v"}},
        f = {"<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = {"n", "v"}},
        x = {
            "<cmd>ChatGPTRun explain_code<CR>",
            "Explain Code",
            mode = {"n", "v"}
        },
        r = {
            "<cmd>ChatGPTRun roxygen_edit<CR>",
            "Roxygen Edit",
            mode = {"n", "v"}
        },
        l = {
            "<cmd>ChatGPTRun code_readability_analysis<CR>",
            "Code Readability Analysis",
            mode = {"n", "v"}
        }
    },
    t = {
        name = "Telescope",
        o = {"<cmd>Telescope oldfiles<CR>", "oldfiles", mode = {"n", "v"}},
        g = {"<cmd>Telescope live_grep<CR>", "live_grep", mode = {"n", "v"}},
        f = {"<cmd>Telescope fd<CR>", "fd", mode = {"n", "v"}},
        k = {"<cmd>Telescope keymaps<CR>", "keymaps", mode = {"n", "v"}},
        b = {"<cmd>Telescope buffers<CR>", "buffers", mode = {"n", "v"}},
        h = {"<cmd>Telescope help_tags<CR>", "help_tags", mode = {"n", "v"}}
    },
    l = {
        name = "LSP",
        g = {"<cmd>LspStart<CR>", "Start LSP", mode = {"n"}},
        k = {"<cmd>LspStop<CR>", "Stop LSP", mode = {"n"}},
        i = {"<cmd>LspInfo<CR>", "LSP Info", mode = {"n"}},
        r = {"<cmd>LspRestart<CR>", "Restart LSP", mode = {"n"}}
    },
    d = {
        name = "DAP",
        d = {dap.toggle_breakpoint, "Toggle Breakpoint", mode = {"n"}},
        c = {dap.continue, "Continue", mode = {"n"}},
        i = {dap.step_into, "Step Into", mode = {"n"}},
        s = {dap.step_over, "Step Over", mode = {"n"}},
        o = {dap.step_out, "Step Out", mode = {"n"}},
        r = {dap.repl.open, "Open REPL", mode = {"n"}},
        l = {dap.run_last, "Run Last", mode = {"n"}},
        p = {dap.pause, "Pause", mode = {"n"}},
        q = {dap.close, "Close", mode = {"n"}},
        e = {dap.disconnect, "Disconnect", mode = {"n"}},
        u = {dapui.toggle, "Toggle UI", mode = {"n"}}
    },
    n = {
        name = "Numbers",
        n = {"<cmd>set number!<CR>", "Toggle line numbers", mode = {"n"}},
        r = {
            "<cmd>set relativenumber!<CR>",
            "Toggle relative line numbers",
            mode = {"n"}
        }
    },
    m = {
        name = "Magma",
        m = {"<cmd>MagmaEvaluateLine<CR>", "Evaluate Line", mode = {"n"}},
        c = {"<cmd>MagmaReevaluateCell<CR>", "Reevaluate Cell", mode = {"n"}},
        d = {"<cmd>MagmaDelete<CR>", "Delete", mode = {"n"}},
        o = {"<cmd>MagmaShowOutput<CR>", "Show Output", mode = {"n"}},
        e = {
            "<cmd>noautocmd MagmaEnterOutput<CR>",
            "Enter Output",
            mode = {"n"}
        }
    },
    e = {"<cmd>NvimTreeToggle<CR>", "NvimTreeToggle", mode = {"n"}},
    u = {"<cmd>UndotreeToggle<CR>", "UndotreeToggle", mode = {"n"}},
    x = {"<cmd>!chmod +x %<CR>", "Make current file executable", mode = {"n"}},
    f = {"<cmd>Neoformat<CR>", "Neoformat", mode = {"n"}}
}, {prefix = "<leader>"})

wk.register({
    ['<space>'] = {
        name = "Diagnostics and LSP",
        p = {vim.diagnostic.goto_prev, 'Go to previous', mode = {'n'}},
        n = {vim.diagnostic.goto_next, 'Go to next', mode = {'n'}},
        q = {vim.diagnostic.setloclist, 'Set Location List', mode = {'n'}},
        e = {vim.diagnostic.open_float, 'Open float', mode = {'n'}},
        t = {vim.lsp.buf.type_definition, 'type definition', mode = {'n'}},
        d = {vim.lsp.buf.declaration, 'declaration', mode = {'n', 'v'}},
        D = {vim.lsp.buf.definition, 'definition', mode = {'n', 'v'}},
        i = {vim.lsp.buf.implementation, 'implementation', mode = {'n', 'v'}},
        h = {vim.lsp.buf.hover, 'hover', mode = {'n', 'v'}},
        s = {vim.lsp.buf.signature_help, 'signature help', mode = {'n', 'v'}},
        r = {vim.lsp.buf.references, 'references', mode = {'n', 'v'}},
        wa = {
            vim.lsp.buf.add_workspace_folder,
            'add workspace folder',
            mode = {'n'}
        },
        wr = {
            vim.lsp.buf.remove_workspace_folder,
            'remove workspace folder',
            mode = {'n'}
        },
        wl = {
            vim.lsp.buf.list_workspace_folders,
            'list workspace folders',
            mode = {'n'}
        },
        rn = {vim.lsp.buf.rename, 'rename', mode = {'n'}},
        ca = {vim.lsp.buf.code_action, 'code action', mode = {'n', 'v'}}
    }
})
