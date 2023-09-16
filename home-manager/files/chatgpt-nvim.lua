require("chatgpt").setup({
    api_key_cmd = "pass show openai",
    openai_params = {
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 1000,
        temperature = 0,
        top_p = 1,
        n = 1
    }
})
vim.keymap.set('n', '<Leader>ch', '<Cmd>ChatGPT<CR>')
vim.keymap.set('n', '<Leader>ca', '<Cmd>ChatGPTActAs<CR>')
vim.keymap.set('n', '<Leader>cc', '<Cmd>ChatGPTCompleteCode<CR>')
vim.keymap.set('n', '<Leader>ce', '<Cmd>ChatGPTEditWithInstructions<CR>')
