require("chatgpt").setup({
    api_host_cmd = "echo https://openrouter.ai/api",
    api_key_cmd = "pass show openrouter",
    openai_params = {
        model ="mistralai/mixtral-8x7b-instruct",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 1000,
        temperature = 0,
        top_p = 1,
        n = 1
    },
    openai_edit_params = {
        model = "mistralai/mixtral-8x7b-instruct",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1
    },
    chat = {keymaps = {cycle_windows = "<C-b>"}}
})
