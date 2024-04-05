require("chatgpt").setup({
    api_key_cmd = "pass show openai",
    openai_params = {
        model = "gpt-4-1106-preview",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 1000,
        temperature = 0,
        top_p = 1,
        n = 1
    },
    openai_edit_params = {
        model = "gpt-4-1106-preview",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1
    },
    chat = {keymaps = {cycle_windows = "<C-b>"}}
})
