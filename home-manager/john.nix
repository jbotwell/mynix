{ pkgs, ... }:

let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {

  imports = [
    ../nixos/fw/overlays.nix
    ./alacritty.nix
    # ./hypr.nix
    ./neovim.nix
    ./tmux.nix
  ];

  home = {
    inherit username homeDirectory;

    packages = with pkgs; [
      calibre
      grim
      libreoffice
      signal-desktop
      slack
      slurp
      vlc
      zathura
      zoom-us
      anki
      obsidian
      exercism
      sox
      rpi-imager
    ];
  };

  xdg = {
    inherit configHome;
    enable = true;
  };

  programs.home-manager.enable = true;

  # Bash
  programs.bash.enable = true;
  # TODO Make bash_it integration more declarative
  programs.bash.initExtra = ''
      export PATH=$PATH:/home/john/.npm/bin
      export BASH_IT="/home/john/.bash_it"
      export BASH_IT_THEME="bobby"
    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi
        source "$BASH_IT"/bash_it.sh'';

  # Syncthing
  services.syncthing.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "John Otwell";
    userEmail = "john.otwell@protonmail.com";
    extraConfig = {
      mergetool.vimdiff = true;
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };

  # fzf
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
    defaultOptions = [ "--height 30%" ]; # FZF_DEFAULT_OPTS
    fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
  };

  # htop
  programs.htop = {
    enable = true;
    settings = {
      sort_direction = true;
      sort_key = "PERCENT_CPU";
    };
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
