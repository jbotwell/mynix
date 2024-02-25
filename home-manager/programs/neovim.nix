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
      neodev-nvim
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
      pkgs.unstable.vimPlugins.ChatGPT-nvim
      pkgs.unstable.vimPlugins.copilot-vim

      # ui tools
      telescope-nvim
      telescope-fzf-native-nvim
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
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-dap-python

      # syntax tools
      nvim-treesitter.withAllGrammars

      # On-the-spot evaluation; Jupyter-like
      magma-nvim-goose

      # Completions
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim

      # language specific
      rust-tools-nvim
      vim-nix

      # other misc
      nvim-autopairs
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
