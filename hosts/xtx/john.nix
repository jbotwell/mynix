{inputs, ...}: let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  imports = [
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/bash.nix
    ../../modules/home-manager/emacs.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/htop.nix
    ../../modules/home-manager/misc-graphical.nix
    ../../modules/home-manager/misc-terminal.nix
    ../../modules/home-manager/tmux.nix
  ];

  home.packages = [inputs.my-nixvim.packages."x86_64-linux".default];

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
