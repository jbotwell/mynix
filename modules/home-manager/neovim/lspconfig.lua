local lspconfig = require('lspconfig')
function add_lsp(binary, server, options)
    if vim.fn.executable(binary) == 1 then server.setup(options) end
end
add_lsp("tsserver", lspconfig.tsserver, {})
add_lsp("nil", lspconfig.nil_ls, {})
add_lsp("marksman", lspconfig.marksman, {})
add_lsp("rust-analyzer", lspconfig.rust_analyzer, {})
add_lsp("lua-language-server", lspconfig.lua_ls, {})
add_lsp("pyright", lspconfig.pyright, {})
add_lsp("json-languageserver", lspconfig.jsonls,
        {cmd = {"json-languageserver", "--stdio"}})
add_lsp("csharp-ls", lspconfig.csharp_ls, {})
