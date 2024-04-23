{ pkgs, ... }:
let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  home.packages = with pkgs; [
    # language servers
    fsautocomplete
    marksman
    lua-language-server
    nil
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver-bin
    rust-analyzer
    shellcheck

    # formatters
    clang-tools
    comrak
    fantomas
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

    extraConfig = builtins.readFile ./neovim/nvim.vim;

    extraLuaConfig = builtins.readFile ./neovim/nvim.lua;

    plugins = with pkgs.vimPlugins; [
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
        config = builtins.readFile ./neovim/lspconfig.lua;
      }
      Ionide-vim

      # keybindings set and help
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./neovim/which-key.lua;
      }

      # ui tools
      telescope-nvim
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = builtins.readFile ./neovim/telescope.lua;
      }
      nui-nvim
      plenary-nvim
      neo-tree-nvim
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup {
            view = {
              width = 60
            }
          }
        '';
      }
      {
        plugin = edgy-nvim;
        type = "lua";
        config = builtins.readFile ./neovim/edgy.lua;
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
          require("toggleterm").setup{}
        '';
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
      {
        plugin = nvim-dap-python;
        type = "lua";
        config = ''
          -- see dap-python readme for this setup (not nix-y)
          require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        '';
      }

      # syntax tools
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./neovim/treesitter.lua;
      }

      # On-the-spot evaluation; Jupyter-like
      magma-nvim-goose

      # Lispy-esque interactions
      {
        plugin = conjure;
        config = ''
          nnoremap L ,
          let g:conjure#mapping#prefix = ","
          let g:conjure#mapping#doc_word = "gk"
        '';
      }

      # Completions
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./neovim/cmp.lua;
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

      # sexp editing
      vim-parinfer
      {
        plugin = vim-sexp;
        config = ''
          let g:sexp_filetypes = 'clojure,lisp,scheme,racket,timl,hy,fennel'
        '';
      }

      # other misc
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup {}
        '';
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require('nvim-surround').setup {}
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
      vim-unimpaired

      # ai assistants
      {
        plugin = pkgs.unstable.vimPlugins.ChatGPT-nvim;
        # uncomment for local
        # plugin = ChatGPT-nvim;
        type = "lua";
        config = builtins.readFile ./neovim/chatgpt.lua;
      }
      pkgs.unstable.vimPlugins.copilot-vim
    ];
  };
}
