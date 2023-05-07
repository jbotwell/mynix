{ pkgs, ... }: {
  programs.neovim = {
    plugins = [ pkgs.vimPlugins.nvim-tree-lua ];
    viAlias = true;
    vimAlias = true;
    vimdiffAliasl = true;
  };
}
