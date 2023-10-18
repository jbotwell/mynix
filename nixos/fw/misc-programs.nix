{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    ungoogled-chromium
    firefox
    unstable.vscode
    nixfmt
    ripgrep
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
    emacs
    gnumake
    gcc
    audacity
    ffmpeg
    pass
    deno
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
