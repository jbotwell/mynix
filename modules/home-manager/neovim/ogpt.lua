ogpt_nvim_options = {
    default_provider = "ollama",
    single_window = false, -- set this to true if you want only one OGPT window to appear at a time
    providers = {
        ollama = {
            api_host = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
            api_key = os.getenv("OLLAMA_API_KEY") or ""
        }
    },
    actions_paths = {"~/code/scripts/ogpt_actions.json"}
}

require("ogpt").setup(ogpt_nvim_options)
