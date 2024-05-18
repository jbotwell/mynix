{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anki
    calibre
    firefox
    libreoffice
    nyxt
    quickemu
    signal-desktop
    slack
    ungoogled-chromium
    unstable.vscode
    vlc
    wireshark
    zathura
    zoom-us
  ];
}
