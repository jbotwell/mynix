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

    extraConfig = builtins.readFile (./files/init.vim);

    extraLuaConfig = builtins.readFile (./files/nvim.lua);

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

      # dap
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text

      # Completions
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./files/cmp.lua;
      }

      # lsp 
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./files/lsp-config.lua;
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
