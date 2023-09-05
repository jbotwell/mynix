local cmp = require('cmp')

cmp.setup {
    formatting = {format = require('lspkind').cmp_format()},
    -- Same keybinds as vim's vanilla completion
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert
        }),
        ['<C-p>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
        }),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm()
    },
    sources = {
        {name = 'buffer', option = {get_bufnrs = vim.api.nvim_list_bufs}},
        {name = 'nvim_lsp'}
    }
}
