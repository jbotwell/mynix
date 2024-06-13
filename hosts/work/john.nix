{inputs, ...}: let
  username = "john_otwell";
  homeDirectory = "/Users/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  imports = [
    ../../modules/home-manager/alacritty-work.nix
    ../../modules/home-manager/bash-work.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/misc-terminal.nix
    ../../modules/home-manager/tmux.nix
  ];

  home.packages = [inputs.my-nixvim.packages."aarch64-darwin".default];

  home = {inherit username homeDirectory;};

  xdg = {
    inherit configHome;
    enable = true;
  };

  # allow unfree in nix-shell, nix-env
  home.file."${configName}/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  programs.home-manager.enable = true;

  home = {stateVersion = "23.11";};
}
