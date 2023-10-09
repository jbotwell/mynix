{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xclip

    ungoogled-chromium
    firefox
    vim
    unstable.vscode
    nixfmt
    ripgrep
    ripgrep-all
    zoxide
    neovim
    wofi
    waybar
    nodejs
    tmux
    wl-clipboard
    xfce.thunar
    nmap
    cargo
    filezilla
    rustfmt
    clippy
    pavucontrol
    comrak
    transmission
    transmission-gtk
    gparted
    python3
    python310Packages.pytest
    tldr
    redis
    jupyter
    jq
    emacs
    gnumake
    gcc
    audacity
    ffmpeg
    pass
    deno
    trezor-suite
    dotnet-sdk_7
    clang
  ];

  # npm
  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.npm
    '';
  };

  # gnupg
  programs.gnupg = {
    agent = {
      enable = true;
      enableExtraSocket = true;
      pinentryFlavor = "gnome3";
    };
  };

  # Trezor
  services.trezord.enable = true;
}
