-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({})

-- toggle open for nvim-tree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>',
                        {noremap = true, silent = true})

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        -- disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat,
                                    vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end
    },
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false
}

require("nvim-autopairs").setup {}

require 'rainbow-delimiters.setup' {}

-- chat-gpt
require("chatgpt").setup({api_key_cmd = "pass show openai"})

-- dap
require('dapui').setup()

