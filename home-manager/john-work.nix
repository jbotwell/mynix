{ pkgs, ... }:

let
  username = "john_otwell";
  homeDirectory = "/Users/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  imports = [
    ../overlays/overlays.nix
    ./programs/alacritty-work.nix
    ./programs/bash-work.nix
    ./programs/emacs.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/htop.nix
    ./programs/misc-terminal.nix
    ./programs/neovim-work.nix
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
}
