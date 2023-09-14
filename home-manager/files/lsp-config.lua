local lspconfig = require('lspconfig')
function add_lsp(binary, server, options)
    if vim.fn.executable(binary) == 1 then server.setup(options) end
end

add_lsp("tsserver", lspconfig.tsserver, {})
add_lsp("rnix-lsp", lspconfig.rnix, {})
add_lsp("marksman", lspconfig.marksman, {})
add_lsp("rust-analyzer", lspconfig.rust_analyzer, {})
add_lsp("lua-language-server", lspconfig.lua_ls, {})
add_lsp("pyright", lspconfig.pyright, {})
add_lsp("json-languageserver", lspconfig.jsonls,
        {cmd = {"json-languageserver", "--stdio"}})
-- astro-ls installed globally; typescript as dev dependency
add_lsp("astro-ls", lspconfig.astro,
        {init_options = {typescript = {tsdk = 'node_modules/typescript/lib'}}})
add_lsp("csharp-ls", lspconfig.csharp_ls, {})
add_lsp("fsautocomplete", lspconfig.fsautocomplete, {})

vim.keymap.set('n', '<Leader>lg', '<Cmd>LspStart<CR>')
vim.keymap.set('n', '<Leader>lk', '<Cmd>LspStop<CR>')
vim.keymap.set('n', '<Leader>li', '<Cmd>LspInfo<CR>')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
                       opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end
})

