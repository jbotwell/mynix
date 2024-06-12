{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
    calibre
    firefox
    libreoffice
    quickemu
    signal-desktop
    slack
    ungoogled-chromium
    vscode
    vlc
    wireshark
    zathura
    zoom-us
  ];
}
