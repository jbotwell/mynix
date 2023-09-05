{ pkgs, ... }: {
  home.packages = with pkgs; [
    # language servers
    marksman
    rnix-lsp
    rust-analyzer
    nodePackages.vscode-json-languageserver-bin
    lua-language-server
    nodePackages.pyright
    nodePackages.typescript-language-server

    # formatters
    python311Packages.black
    nodePackages.prettier
    nixfmt
    luaformatter
    jq
  ];

  programs.neovim = {
    enable = true;

    # use nvim instead of vi, vim, vimdiff
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
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      nvim-web-devicons
      nvim-treesitter.withAllGrammars
      vim-sneak
      vim-commentary
      vim-numbertoggle
      undotree
      vim-textobj-entire
      vim-surround
      plenary-nvim
      neoformat
      nvim-autopairs
      pkgs.unstable.vimPlugins.rainbow-delimiters-nvim

      # chat-gpt and dependencies
      ChatGPT-nvim
      nui-nvim
      plenary-nvim
      telescope-nvim

      # copilot
      copilot-vim

      # Completions
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim
      {
        plugin = nvim-cmp;
        type = "lua";
        config = # lua
          ''
            local cmp = require('cmp')

            cmp.setup{
              formatting = { format = require('lspkind').cmp_format() },
              -- Same keybinds as vim's vanilla completion
              mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-e>'] = cmp.mapping.close(),
                ['<C-y>'] = cmp.mapping.confirm(),
              },
              sources = {
                { name='buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
                { name='nvim_lsp' },
              },
            }
          '';
      }

      # lsp 
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = # lua
          ''
            local lspconfig = require('lspconfig')
                      function add_lsp(binary, server, options)
                            if vim.fn.executable(binary) == 1 then server.setup(options) end
                      end

                      add_lsp("tsserver", lspconfig.tsserver, {})
                      add_lsp("rnix-lsp", lspconfig.rnix, {})
                      add_lsp("marksman", lspconfig.marksman, {})
                      add_lsp("rust-analyzer", lspconfig.rust_analyzer, {})
                      add_lsp("lua-language-server", lspconfig.lua_ls, {})
                      add_lsp("pyright", lspconfig.pyright, {})
                      add_lsp("json-languageserver", lspconfig.jsonls, {
                        cmd = { "json-languageserver", "--stdio" }
                      })
                      -- astro-ls installed globally; typescript as dev dependency
                      add_lsp("astro-ls", lspconfig.astro, {
                        init_options = {
                          typescript = {
                            tsdk = 'node_modules/typescript/lib'
                          }
                        }
                      })

                      -- Global mappings.
                      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
                      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
                      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
                      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
                      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

                      -- Use LspAttach autocommand to only map the following keys
                      -- after the language server attaches to the current buffer
                      vim.api.nvim_create_autocmd('LspAttach', {
                            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                            callback = function(ev)
                                    -- Enable completion triggered by <c-x><c-o>
                                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                                    -- Buffer local mappings.
                                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                                    local opts = { buffer = ev.buf }
                                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                                    vim.keymap.set('n', '<space>wl', function()
                                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                    end, opts)
                                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                            end,
            })
          '';
      }
      # rust tools
      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = # lua
          ''
            local rust_tools = require('rust-tools')
            if vim.fn.executable("rust-analyzer") == 1 then
              rust_tools.setup{ tools = { autoSetHints = true } }
            end
            vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
          '';
      }
    ];
  };
}
