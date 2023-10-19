{ pkgs, ... }:

let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  imports = [
    ../nixos/fw/overlays.nix
    ./neovim.nix
    ./programs/alacritty.nix
    ./programs/bash.nix
    ./programs/dotnet.nix
    ./programs/emacs.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/htop.nix
    ./programs/misc-graphical.nix
    ./programs/misc-terminal.nix
    ./programs/tmux.nix
  ];

  programs.home-manager.enable = true;

  home = { inherit username homeDirectory; };

  xdg = {
    inherit configHome;
    enable = true;
  };

  # allow unfree in nix-shell, nix-env
  home.file."${configName}/nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';

  home = { stateVersion = "22.11"; };

  # emacs, doom
  # home.file.".emacs.d" = {
  #   source = files/emacs.d;
  #   recursive = true;
  # };
}
