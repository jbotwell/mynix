{ pkgs, ... }: {
  imports = [ ./neovim-lsp.nix ];

  programs.neovim = with pkgs; {
    enable = true;

    plugins = [
      vimPlugins.nvim-tree-lua
      vimPlugins.nvim-web-devicons
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.neorg
      vimPlugins.vim-sneak
      vimPlugins.vim-commentary
      vimPlugins.vim-numbertoggle
      vimPlugins.undotree
      vimPlugins.vim-textobj-entire
      vimPlugins.vim-surround
      vimPlugins.plenary-nvim
      vimPlugins.neoformat
      vimPlugins.nvim-autopairs
      unstable.vimPlugins.rainbow-delimiters-nvim

      # chat-gpt and dependencies
      vimPlugins.ChatGPT-nvim
      vimPlugins.nui-nvim
      vimPlugins.plenary-nvim
      vimPlugins.telescope-nvim

      # copilot
      vimPlugins.copilot-vim

      # language specific
      vimPlugins.vim-nix
      unstable.vimPlugins.vim-astro
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      " Enable italic font rendering
      if has('nvim')
      let &t_ZH = "\e[3m"
      let &t_ZR = "\e[23m"
      else
      let &t_ZH = "\<Esc>[3m"
      let &t_ZR = "\<Esc>[23m"
      endif

      " Enable italics in the terminal
      if !has('gui_running') && &t_Co >= 256
      " For 256-color terminals
      silent !echo -ne "\e]12;gray40\a"
      endif

      " Enable relative line numbers by default
      set number

      " Define a mapping to toggle between relative and absolute line numbers
      nnoremap <silent> <C-n> :set relativenumber!<cr>

      " undotree to leader u
      nnoremap <Leader>u :UndotreeToggle<CR>

      set shiftwidth=2

      " vim-astro with TypeScript
      let g:astro_typescript = 'enable'

      " NeoFormat
      nnoremap <Leader>f :Neoformat<CR>
      " Try local executable for node
      let g:neoformat_try_node_exe = 1

      " Rainbow
      let g:rainbow_active = 1

    '';
    extraLuaConfig = ''
      -- disable netrw at the very start of your init.lua (strongly advised)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require("nvim-tree").setup({})

      -- toggle open for nvim-tree
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

      -- nvim-treesitter
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          -- disable slow treesitter highlight for large files
          disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,
        },
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,
      }

      require("nvim-autopairs").setup {}

      require 'rainbow-delimiters.setup' {}

      -- chat-gpt
      require("chatgpt").setup({
        api_key_cmd = "pass show openai"
      })

      -- see diagnostics in popup
      vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
    '';
  };
}
