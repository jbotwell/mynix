{ pkgs, ... }:
let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  home.packages = with pkgs; [
    # language servers
    marksman
    rnix-lsp
    rust-analyzer
    nodePackages.vscode-json-languageserver-bin
    lua-language-server
    nodePackages.pyright
    nodePackages.typescript-language-server
    shellcheck

    # formatters
    clang-tools
    comrak
    luaformatter
    nixfmt
    nodePackages.prettier
    python310Packages.black
    rustfmt

    # debuggers
    netcoredbg
  ];

  programs.neovim = {
    enable = true;

    # use nvim instead of vi, vim, vimdiff
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraConfig = builtins.readFile (../neovim/nvim.vim);

    extraLuaConfig = builtins.readFile (../neovim/nvim.lua);

    plugins = with pkgs.vimPlugins; [
      # package management
      lazy-nvim
      packer-nvim

      # lsp/dev tools
      {
        plugin = neodev-nvim;
        type = "lua";
        config = ''
          require("neodev").setup {}
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
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
          add_lsp("json-languageserver", lspconfig.jsonls,
                  {cmd = {"json-languageserver", "--stdio"}})
          add_lsp("csharp-ls", lspconfig.csharp_ls, {})
          add_lsp("fsautocomplete", lspconfig.fsautocomplete, {})
        '';
      }

      # keybindings set and help
      which-key-nvim

      # ai assistants
      {
        plugin = pkgs.unstable.vimPlugins.ChatGPT-nvim;
        type = "lua";
        config = ''
                    require("chatgpt").setup ({
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
        '';
      }
      pkgs.unstable.vimPlugins.copilot-vim

      # ui tools
      telescope-nvim
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = ''
          require('telescope').setup {
              extensions = {
                  fzf = {
                      fuzzy = true,
                      override_generic_sorter = true,
                      override_file_sorter = true,
                      case_mode = "smart_case"
                  }
              }
          }
          -- To get fzf loaded and working with telescope, you need to call
          -- load_extension, somewhere after setup function:
          require('telescope').load_extension('fzf')
        '';
      }
      nui-nvim
      plenary-nvim
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup {
              view = {
                  width = 60
              }
          }'';
      }

      # debugging
      nvim-dap
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config = ''
          require("dapui").setup {}
        '';
      }
      nvim-dap-virtual-text
      nvim-dap-python

      # syntax tools
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          -- treesitter recommended setup
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
              -- set to false if you don't have `tree-sitter` CLI installed locally
              auto_install = false
          }
        '';
      }

      # On-the-spot evaluation; Jupyter-like
      magma-nvim-goose

      # Completions
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
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
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim

      # language specific
      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = ''
          -- rust-tools recommended setup
          local rust_tools = require('rust-tools')
          if vim.fn.executable("rust-analyzer") == 1 then
              rust_tools.setup {tools = {autoSetHints = true}}
          end
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
      }
      vim-nix

      # other misc
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup {}
        '';
      }
      pkgs.unstable.vimPlugins.rainbow-delimiters-nvim
      neoformat
      nvim-web-devicons
      vim-sneak
      vim-commentary
      vim-numbertoggle
      undotree
      vim-textobj-entire
      vim-surround
    ];
  };
}
