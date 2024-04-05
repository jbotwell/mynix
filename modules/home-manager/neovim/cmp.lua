-- nvim-cmp recommended setup
local cmp = require("cmp")
cmp.setup {
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- popup not to show more than maxwidth characters
            ellipsis_char = '...' -- after maxwidth reached, show this ellipsis character
        })
    },
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
