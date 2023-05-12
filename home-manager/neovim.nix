{ pkgs, ... }: {
  programs.neovim = with pkgs; {
    plugins = [
      vimPlugins.nvim-tree-lua
      vimPlugins.nvim-web-devicons
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-lsputils
      vimPlugins.neorg

      # language specific
      vimPlugins.vim-nix
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # config from nvim-tree gh
    extraLuaConfig = ''
      -- disable netrw at the very start of your init.lua (strongly advised)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      require("nvim-tree").setup({})

      -- toggle open for nvim-tree
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    '';
  };

  home.packages = with pkgs; [ nixfmt ];
}
