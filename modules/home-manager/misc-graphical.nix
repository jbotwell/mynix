{pkgs, ...}: {
  home.packages = with pkgs; [
    anki
    calibre
    firefox
    libreoffice
    pkgs23.obsidian
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
