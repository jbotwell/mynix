{ pkgs, ... }: {

  programs.neovim.plugins = with pkgs.vimPlugins; [
    # LSP
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
          add_lsp("json-languageserver", lspconfig.jsonls, {
            cmd = { "json-languageserver", "--stdio" }
          })
          add_lsp("lua-language-server", lspconfig.lua_ls, {})
          add_lsp("pyright", lspconfig.pyright, {})
          -- astro-ls needs to be installed globally and typescript needs to be installed as dev dependency
          add_lsp("astro-ls", lspconfig.astro, {
            init_options = {
              typescript = {
                tsdk = 'node_modules/typescript/lib'
              }
            }
          })

          -- Autoformatters
          -- vim.cmd [[autocmd BufWritePre *.nix :silent! %!nixfmt]]
          -- vim.cmd [[autocmd BufWritePre *.py :silent! %!black - --quiet]]


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
  ];

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
  ];
}
