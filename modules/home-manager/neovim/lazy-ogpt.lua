local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "huynle/ogpt.nvim",
    event = "VeryLazy",
    opts = {
        default_provider = "ollama",
        providers = {
            ollama = {
                api_host = os.getenv("OLLAMA_API_HOST") or
                    "http://localhost:11434",
                api_key = os.getenv("OLLAMA_API_KEY") or ""
            }
        }
    }
})

