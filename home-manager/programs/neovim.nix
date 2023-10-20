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

    # magma dependencies
    python310Packages.pynvim
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
    defaultEditor = true;

    extraConfig = builtins.readFile (../neovim/nvim.vim);

    extraLuaConfig = builtins.readFile (../neovim/nvim.lua);

    plugins = with pkgs.vimPlugins; [
      # package management
      lazy-nvim
      packer-nvim

      # lsp/dev tools
      neodev-nvim
      nvim-lspconfig

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
      nvim-tree-lua

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
