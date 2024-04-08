{ pkgs, ... }:

let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  imports = [
    ../../overlays/overlays.nix
    ../../modules/home-manager/alacritty.nix
    ../../modules/home-manager/bash.nix
    ../../modules/home-manager/dotnet.nix
    ../../modules/home-manager/emacs.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/haskell.nix
    ../../modules/home-manager/htop.nix
    ../../modules/home-manager/js.nix
    ../../modules/home-manager/misc-graphical.nix
    ../../modules/home-manager/misc-terminal.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/python.nix
    ../../modules/home-manager/tmux.nix
  ];

  home = { inherit username homeDirectory; };

  xdg = {
    inherit configHome;
    enable = true;
  };

  # allow unfree in nix-shell, nix-env
  home.file."${configName}/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  programs.home-manager.enable = true;

  home = { stateVersion = "22.11"; };
}
