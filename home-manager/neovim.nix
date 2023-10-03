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

    # formatters
    python310Packages.black
    nodePackages.prettier
    nixfmt
    luaformatter
    jq
    clang-tools

    # debuggers
    netcoredbg

    # magma dependencies
    python310Packages.pynvim
    python310Packages.jupyter_client
    python310Packages.ueberzug
    python310Packages.pillow
    python310Packages.cairosvg
    python310Packages.pnglatex
    python310Packages.plotly
    python310Packages.pyperclip
  ];

  programs.neovim = {
    enable = true;

    # use nvim instead of vi, vim, vimdiff
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = builtins.readFile (./files/nvim.vim);

    extraLuaConfig = builtins.readFile (./files/nvim.lua);

    plugins = with pkgs.vimPlugins; [
      # neodev; keep before lspconfig
      {
        plugin = neodev-nvim;
        type = "lua";
        config = ''
          require("neodev").setup {}
        '';
      }

      # lsp 
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./files/lsp-config.lua;
      }

      # which-key
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          require("which-key").setup {}
        '';
      }

      # chat-gpt and dependencies
      {
        plugin = pkgs.unstable.vimPlugins.ChatGPT-nvim;
        type = "lua";
        config = builtins.readFile ./files/chatgpt-nvim.lua;

      }
      nui-nvim
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          vim.keymap.set('n', '<Leader>to', '<Cmd>Telescope oldfiles<CR>')
          vim.keymap.set('n', '<Leader>tg', '<Cmd>Telescope live_grep<CR>')
          vim.keymap.set('n', '<Leader>tf', '<Cmd>Telescope fd<CR>')
          vim.keymap.set('n', '<Leader>tk', '<Cmd>Telescope keymaps<CR>')
          vim.keymap.set('n', '<Leader>tc', '<Cmd>Telescope keymaps<CR>')
        '';
      }

      # copilot
      copilot-vim

      # dap
      {
        plugin = nvim-dap;
        type = "lua";
        config = builtins.readFile ./files/dap.lua;
      }
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config = ''
          require("dapui").setup()
          vim.keymap.set('n', '<Leader>du', require('dapui').open)
          vim.keymap.set('n', '<Leader>de', require('dapui').close)
        '';
      }
      nvim-dap-virtual-text
      {
        plugin = nvim-dap-python;
        type = "lua";
        config = ''
          -- debugpy must be installed to this virtual environment
          -- the process is described in the 'nvim-dap-python' readme
          require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
        '';
      }

      # tree
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({})
          -- toggle open for nvim-tree
          vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>',
                                  {noremap = true, silent = true})
        '';
      }

      # treesitter; syntax help
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
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
        '';
      }

      # Jupyter
      magma-nvim-goose

      # Completions
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./files/cmp.lua;
      }

      # rust tools
      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = ''
          local rust_tools = require('rust-tools')
          if vim.fn.executable("rust-analyzer") == 1 then
            rust_tools.setup{ tools = { autoSetHints = true } }
          end
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
      }

      # other misc
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup {}
        '';
      }
      {
        plugin = pkgs.unstable.vimPlugins.rainbow-delimiters-nvim;
        type = "lua";
        config = ''
          require 'rainbow-delimiters.setup' {}
        '';
      }
      neoformat
      nvim-web-devicons
      vim-sneak
      vim-commentary
      vim-numbertoggle
      undotree
      vim-textobj-entire
      vim-surround
      plenary-nvim
      nvim-autopairs
      vim-nix
    ];
  };
}
